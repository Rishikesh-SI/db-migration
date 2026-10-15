-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: get_master_player_list_r(jsonb)
-- Type: FUNCTION

-- Name: get_master_player_list_r(jsonb); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.get_master_player_list_r(p_filters jsonb, OUT p_player_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
DECLARE
	
	v_fromrownumber numeric;
    v_torownumber numeric;
	v_pgnum numeric;
	v_pgsize numeric;
	
    v_entity_name character varying;
	v_gender character varying;
	v_order character varying;
	v_groupid numeric;
	v_entitytypeid numeric;
	v_itemnumber numeric;
	v_percent text;
	
	v_entity_name_filter varchar(100) := ' ';
	v_gender_filter varchar(100) := ' ';
	v_order_filter varchar(100) := ' ';
	v_player_id_arr numeric[];
	v_try character varying;

BEGIN

--{"groupid":"1","pgnum":"1","entitytypeid":"14","initial":"n","gender":"female","pgsize":"10","order":"desc"}

v_groupid := p_filters->> 'groupid';
v_pgsize := p_filters->> 'pgsize';
v_pgnum:= p_filters->>'pgnum';
v_itemnumber:=10;

v_entitytypeid := p_filters ->> 'entitytypeid';

v_entity_name:= p_filters->>'initial';
v_gender := p_filters->>'gender';
v_order := p_filters->>'order';

v_entity_name:= v_entity_name||'%';

if v_pgsize is null then
    	v_fromrownumber := (v_pgnum * v_itemnumber - (p_itemnumber - 1));
		-- raise notice 'v_fromrownumber %',v_fromrownumber;
        v_torownumber   := v_pgnum * v_itemnumber;
		-- raise notice 'v_torownumber %', v_torownumber;
	else
    	if v_pgnum = 1 then
        	v_fromrownumber := (v_pgnum * v_itemnumber - (v_itemnumber - 1));
		else
        	v_fromrownumber := v_pgsize + ( (( (v_pgnum-1) * v_itemnumber) - (v_itemnumber - 1)));
		end if;
		v_torownumber   := v_pgsize + ( (v_pgnum-1) * v_itemnumber);
end if;

if v_entity_name is not null then
    	v_entity_name_filter := ' and entity_name ilike $1';  --eg and entity_name = 'n%'
		
	end if;

if v_gender is not null then
    	v_gender_filter := ' and add_info->''data''->>''gender'' ilike $2 ';
	end if;
	
if v_order= 'desc' then
    	v_order_filter := ' order by entity_name desc ';
		else 
		v_order_filter := ' order by entity_name asc ';
	end if;
	
raise notice 'v_entity_name :%',v_entity_name;
raise notice 'v_gender :%',v_gender;
raise notice 'v_order :%',v_order;

	execute 'select array(select entity_master_id
								from(select entity_master_id, row_number() over(order by updated_date desc) rno
										from labwis.labwis_entity_master
										where  is_deleted=0 and is_active=1'
										||v_entity_name_filter
										||v_gender_filter
										--||v_order_filter
										||') tab
								where rno between $4 and $5)'
		using  v_entity_name,v_gender, v_order, v_fromrownumber, v_torownumber
		into v_player_id_arr;
		
	---------------------
	execute 'select (''{"data":''||json_agg(row_to_json(row))::text||''}'')::jsonb
			from (select entity_master_id, entity_name,source_object_id ,gender from 
			  (select em.entity_name as entity_name ,em.entity_master_id as entity_master_id,rm.source_object_id as source_object_id 
				  , em.add_info->''data''->>''gender'' as gender
						from labwis.labwis_entity_master em
						join labwis.labwis_entity_role_map rm on em.entity_master_id=em.entity_master_id
						join labwis.labwis_entity_role r on rm.entity_role_id=r.entity_role_id

				  WHERE r.entity_type_id=$4 and r.entity_group_id=$5
				   '
 										||v_entity_name_filter
										||v_gender_filter
										||v_order_filter
 										||'
										 limit 10)a)row'
			using  v_entity_name,v_gender, v_order,v_entitytypeid,v_groupid
			into p_player_json;
			
			if p_player_json is null 
		    then p_player_json := '{"items":[]}'::jsonb;
			end if;

END;
$_$;


--
