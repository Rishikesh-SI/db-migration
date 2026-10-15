-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_get_match_centre_listing(numeric, numeric, character varying, text, numeric, numeric)
-- Type: FUNCTION

-- Name: labhkind_get_match_centre_listing(numeric, numeric, character varying, text, numeric, numeric); Type: FUNCTION; Schema: labhkind; Owner: -
--

CREATE FUNCTION labhkind.labhkind_get_match_centre_listing(p_sport_id numeric, p_series_id numeric, p_match_id character varying, p_search text, p_page_number numeric, p_item_number numeric, OUT p_count numeric, OUT p_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare
	
    v_from_row_number numeric := ((p_page_number * p_item_number) - (p_item_number - 1));
    v_to_row_number numeric := (p_page_number * p_item_number);
    v_sport_id_query text := ' ';
    v_series_id_query text := ' ';
    v_match_id_query text := ' ';
    v_search text := lower(p_search);
    v_search_query text := ' ';
    v_match_centre_json_arr jsonb[];
    v_match_centre_json json;
    v_match_centre_json_text text;
    v_json_text text := '{"data": [';
    
begin
	
    if p_sport_id is not null then
    	v_sport_id_query := ' and sport_id = $1 ';
    end if;
    
    if p_series_id is not null then
    	v_series_id_query := ' and series_id = $2 ';
    end if;
    
    if p_match_id is not null then
    	v_match_id_query := ' and match_id = $3 ';
    end if;
    
    if p_search is not null then
    	v_search_query := ' and lower(match_title) like ''%''||'||'$4'||'||''%'' ';
    end if;
    
    execute 'select count(1)
    			from   labhkind.labhkind_match_centre
                where  1 = 1 
				and is_active = 1 and is_published = 1'
			||v_sport_id_query
            ||v_series_id_query
            ||v_match_id_query
            ||v_search_query
	into    p_count
    using   p_sport_id, p_series_id, p_match_id, v_search;
    
    if p_count > 0 then
    	
        execute 'select array(
        			select match_centre_json
                    from   (select match_centre_json, row_number() over(order by created_date desc) rno
                    		from   labhkind.labhkind_match_centre
                            where  1 = 1
							and is_active = 1 and is_published = 1'
                            ||v_sport_id_query
                            ||v_series_id_query
                            ||v_match_id_query
                            ||v_search_query
                            ||') tab
					where  rno between $5 and $6)'
		into    v_match_centre_json_arr
    	using   p_sport_id, p_series_id, p_match_id, v_search, v_from_row_number, v_to_row_number;
        
        foreach v_match_centre_json in array v_match_centre_json_arr
        loop
        	
            v_match_centre_json_text := v_match_centre_json::text;
            v_match_centre_json_text := replace(v_match_centre_json_text,'{"data":','');
            v_match_centre_json_text := substring(v_match_centre_json_text, 1, (length(v_match_centre_json_text) - 1));
            v_json_text := v_json_text||v_match_centre_json_text||',';
            
        end loop;
        
        v_json_text := trim(trailing ',' from v_json_text)||']}';
        p_json := v_json_text::jsonb;
        
    else
    	
        p_json := '{"data":[]}';
        
    end if;
    
end;
$_$;


--
