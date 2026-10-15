-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_get_institute_listing(numeric, text, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: spz_get_institute_listing(numeric, text, numeric, numeric, numeric); Type: FUNCTION; Schema: spz; Owner: -
--

CREATE FUNCTION spz.spz_get_institute_listing(p_city_id numeric, p_search text, p_category_id numeric, p_page_number numeric, p_item_number numeric, OUT p_institute_count numeric, OUT p_institute_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	v_from_row_number numeric;
    v_to_row_number numeric;
	v_search text := lower(p_search);
	v_search_query text := ' ';
    v_category_query text ;
begin
	v_from_row_number := (p_page_number * p_item_number - (p_item_number - 1));
    v_to_row_number := (p_page_number * p_item_number);
    
    v_category_query := '' ;
	
	if p_city_id is null
	then 
	p_city_id:=0;
	end if;
    
	if v_search is not null then
		v_search_query := ' and lower(institute_name) like ''%''||'||'$1'||'||''%'' ';
	end if;
    
    if coalesce(p_category_id,0) != 0  
    then
    
		v_category_query := ' and  exists (select * from spz.spz_player_institute_map pi
                                            inner join spz.spz_player_master p
                                            on (pi.player_id = p.player_id)
                                            where pi.institute_id = I.institute_id
                                            and p.category_id = ' || p_category_id::text ||'
   							 ) ';
	end if;
    
   
    execute 'select count(1) from spz.spz_institute_master I
    			where city_id = case '||p_city_id||' when 0 then city_id else '||p_city_id||' end'
				||v_search_query
                ||v_category_query 
	into p_institute_count
	using v_search;
    
    execute 'select (''{"institutes":[''||string_agg((row_to_json(row))::text,'','')||'']}'')::jsonb
				from (select *
                		from (select I.*, c.city_name,s.state_id,s.state_name,
						row_number() over(order by institute_name) slno
						from spz.spz_institute_master I
                        inner join spz.spz_city_master c 	
                        on (I.city_id = c.city_id)
						left join spz.spz_state_master s
						   on (s.state_id = c.state_id)
                        		where I.city_id  = case '||p_city_id||' when 0 then I.city_id  else '||p_city_id||' end'
                                || v_category_query
                                ||v_search_query||')tab
						where slno between $2 and $3)row'
	into p_institute_json
	using v_search, v_from_row_number, v_to_row_number;
    
    
end;

$_$;


--
