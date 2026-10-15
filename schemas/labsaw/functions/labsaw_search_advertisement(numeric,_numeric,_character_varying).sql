-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_search_advertisement(numeric, numeric, character varying)
-- Type: FUNCTION

-- Name: labsaw_search_advertisement(numeric, numeric, character varying); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_search_advertisement(p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, OUT p_entityjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
 

declare
	   v_fromrownumber numeric;
    v_torownumber numeric;
     v_searchkeyword varchar(4000) := upper(p_searchkeyword);
     v_addsearchquery varchar(4000) := ' ';
     v_addjsonarr jsonb[];
     v_addjson jsonb;
     v_json varchar(30000) := '{"advertisement":[';     
     v_add_count numeric:=0;
begin
     v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
     v_torownumber   := (p_pagenumber * p_itemnumber);
	 
     if v_searchkeyword is not null then
     	
       --  v_addsearchquery := ' and upper(entity_name) like ''%''||'||'$1'||'||''%'' ';
         --      v_addsearchquery := ' and to_tsvector( entity_name) @@@ to_tsquery( ''*''||'||'$1'||'||'':*'')';
              v_addsearchquery := ' and to_tsvector(ad_title) @@@ to_tsquery( '||'$1'||')';
              v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
     end if;
     
        --           raise notice '%',v_searchkeyword;              
     execute 'select array(select row_to_json(tab)
     				  from   (select ad_title,ad_id,
                              row_number() over(order by ad_title nulls last ) slno
                           	  from   labsaw.labsaw_advertisement
                              where  1=1 '
                              ||v_addsearchquery||
                              'and is_active       = 1
                               and  is_deleted      = 0
							   and is_published = 1)  as tab
                               where  slno between '||'$2'||' and '||'$3'||'
                               )
                                   '
	into   v_addjsonarr
     using  v_searchkeyword, v_fromrownumber, v_torownumber;
	 
   --   raise notice '%',v_searchkeyword;    
	  
     foreach v_addjson in array v_addjsonarr
     loop
     	v_json := v_json||v_addjson||',';
     end loop;
     
     	select count(1)
    	into    v_add_count
    	from    unnest(v_addjsonarr) add_id ;
        
    -- v_json := substring(v_json,1,(length(v_json)-1))||']}';
     if v_add_count>0 then
     v_json:= substring(v_json,1,(length(v_json)-1));
     else 
     v_json:= substring(v_json,1,(length(v_json)));
     end if;
      
      v_json := v_json||']}';
      
     p_entityjson := v_json::jsonb;
     
end;

 
$_$;


--
