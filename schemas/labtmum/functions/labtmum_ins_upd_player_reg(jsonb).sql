-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtmum
-- Object: labtmum_ins_upd_player_reg(jsonb)
-- Type: FUNCTION

-- Name: labtmum_ins_upd_player_reg(jsonb); Type: FUNCTION; Schema: labtmum; Owner: -
--

CREATE FUNCTION labtmum.labtmum_ins_upd_player_reg(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
     v_player_id numeric;
	v_guid text;
	v_json jsonb;
	v_first_name varchar(1000);
	v_middle_name varchar(1000);
	v_last_name varchar(1000);
	v_mca_reg_number text;
	
begin
	
     v_json := p_json;
     
  	select v_json->'data'->>'player_id', v_json->'data'->>'first_name', v_json->'data'->>'middle_name', v_json->'data'->>'last_name',
     		v_json->'data'->>'mca_reg_number'
	into v_player_id, v_first_name, v_middle_name, v_last_name, v_mca_reg_number;
     
	if not exists(select 1 from labtmum.labtmum_player_reg where player_json->'data'->>'mca_reg_number' = v_mca_reg_number) then
     	v_player_id := nextval('labtmum.seq_labtmum_player_id');
   		v_guid := uuid_generate_v4();
    		v_json := jsonb_set(v_json, '{data,guid}', ('"'||v_guid||'"')::text::jsonb, true);	 
		v_json := jsonb_set(v_json, '{data,player_id}', v_player_id::text::jsonb, true);
     	insert into labtmum.labtmum_player_reg(player_id, first_name, middle_name, last_name, player_json, guid, created_date)
          values (v_player_id, v_first_name, v_middle_name, v_last_name, v_json, v_guid, current_timestamp);
          p_result := v_player_id;
	else
     	p_result := -1;
	end if;
     
     p_data:=v_json;
     
/*if v_player_id is null then 

   v_player_id:=nextval('labtmum.seq_labtmum_player_id');
   v_guid :=uuid_generate_v4();
    v_json := jsonb_set(v_json, '{data,guid}', ('"'||v_guid||'"')::text::jsonb, true);
		 
	v_json := jsonb_set(v_json, '{data,player_id}', v_player_id::text::jsonb, true);
     insert into labtmum.labtmum_player_reg(player_id ,first_name ,middle_name ,last_name ,player_json ,guid,created_date )
	 values (v_player_id,v_first_name,v_middle_name,v_last_name,v_json,v_guid,current_timestamp);
else 

   update labtmum.labtmum_player_reg
   set  first_name=v_first_name,
   		middle_name=v_middle_name,
		last_name=v_last_name,
		player_json=v_json,
		created_date=current_timestamp
   where player_id=v_player_id;

end if;*/

 exception
when others then
   	p_result := -1;
      p_data := '{}'::jsonb;
end;

$$;


--
