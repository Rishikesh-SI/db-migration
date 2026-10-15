-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: labpkl_get_user_calendar_data(numeric, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labpkl_get_user_calendar_data(numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: labpkl; Owner: -
--

CREATE FUNCTION labpkl.labpkl_get_user_calendar_data(p_page_number numeric, p_item_number numeric, p_season_id numeric, p_type_id numeric, OUT p_user_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
 

declare

v_from_row_number numeric;
v_to_row_number numeric;
v_typequery text := ' ' ;

begin

if p_page_number is not null and p_item_number is not null then
		v_from_row_number := ((p_page_number - 1) * p_item_number) + 1;
		v_to_row_number := p_page_number * p_item_number;
end if;

	/*if p_type_id = 1 then
	
	 v_typequery:= 'and type = 1';
	 
	elsif p_type_id = 2 then
	
	 v_typequery:= 'and type = 2';
	 
	end if;*/

			execute 'select (''{"items":''||json_agg(items)::text||''}'' )::jsonb 
					from (select team as items
						  from (select team,row_number()over (order by user_calendar_id) as rno 
								from labpkl.labpkl_user_calendar
								where season_id = '||p_season_id || '
								and type = '|| p_type_id ||') tab
						  where rno between '||v_from_row_number||' and '||v_to_row_number||') row'
      		into p_user_data;
			
	if p_user_data is null then 

		p_user_data :=  null;

	end if;

   exception
   when others then 
		p_user_data := null;
	   
end;

$$;


--
