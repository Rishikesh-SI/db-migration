-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_check_slugurl(numeric, character varying)
-- Type: FUNCTION

-- Name: labdv_check_slugurl(numeric, character varying); Type: FUNCTION; Schema: labdv; Owner: -
--

CREATE FUNCTION labdv.labdv_check_slugurl(p_assetid numeric, p_slugurl character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$ 

declare
	
     v_query varchar(30) := ' ';
     v_slugcount numeric;
     v_slugurl varchar(4000) := upper(p_slugurl);
     
begin

	p_result := 0;
     
	if p_assetid is not null then
     	
          v_query := ' and asset_id <> $1 ';
              
     end if;
     
     execute 'select count(1)
              from   labdv.labdv_asset_list
              where  upper(title_alias) = $2'
              ||v_query
              into   strict v_slugcount
	using    p_assetid, v_slugurl;
	
     if v_slugcount > 0 then
		p_result := 1;
	end if;
     
exception
	
     when others then
     	p_result := -1;

end;

 $_$;


--
