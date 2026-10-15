-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_get_content_type_listing_r(numeric, numeric, numeric, character varying)
-- Type: FUNCTION

-- Name: labrr_get_content_type_listing_r(numeric, numeric, numeric, character varying); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_get_content_type_listing_r(p_pagenumber numeric, p_itemnumber numeric, p_ispublish numeric, p_searchkeyword character varying, OUT p_contenttypecount numeric, OUT p_contenttypejson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare

  v_json text := '{"items":[';
  v_fromrownumber numeric;
v_torownumber numeric;
	v_searchkeyword text := upper(p_searchkeyword);
		v_searchdraftquery text := ' ';
    v_entitysearchquery varchar(4000) := ' ';
v_limit numeric;
v_offset numeric;
begin

  --  v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  --  v_torownumber   := (p_pagenumber * p_itemnumber);
   
 		v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    	v_torownumber   := (p_pagenumber * p_itemnumber);

    
   if v_searchkeyword is not null then
     	
                v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
                v_entitysearchquery := ' and ( to_tsvector( at.title) @@@ to_tsquery( '''||v_searchkeyword||''') 
                                        or   to_tsvector( at.asset_desc) @@@ to_tsquery( '''||v_searchkeyword||'''))';
                
     end if;
		
    execute 'select ''{"items":[''||string_agg(row_to_json(tab)::text,'','')||'']}'' 
	from (
	select * from 
	(select asset_type_id,title,asset_desc,entity_role_id,is_content_type,row_number() over(order by created_date desc)
    from   labRR.labRR_asset_type at
    where  at.is_active=1
    and    at.is_deleted=0
	and is_publish = $3
     '||v_entitysearchquery|| '
	and at.is_content_type = 1
	order by at.created_date desc
	)tab1
	)tab
	where row_number between $1 and $2
	
    '
    into   p_contenttypejson
    using  v_fromrownumber,v_torownumber,p_ispublish;
   

execute 'select count(1)
    from   labRR.labRR_asset_type at
   where  at.is_active=1
    and    at.is_deleted=0
     '||v_entitysearchquery|| '
	and at.is_content_type = 0
	and is_active=1
	and is_deleted=0
	and is_publish = $3

    '
	into p_contenttypecount
    using   v_fromrownumber,v_torownumber,p_ispublish;
   		
raise notice 'p_contenttypejson %',p_contenttypejson;

if (p_contenttypejson='{"items":[]}') or (p_contenttypejson is null ) then 
	 p_contenttypecount := -1;
          p_contenttypejson  := '{"items":[],
		  						 "ErrorMessage":""}';
end if;

end;
$_$;


--
