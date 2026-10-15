-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_ins_upd_component(jsonb)
-- Type: FUNCTION

-- Name: jafc_ins_upd_component(jsonb); Type: FUNCTION; Schema: jafc; Owner: -
--

CREATE FUNCTION jafc.jafc_ins_upd_component(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare

v_json 								jsonb;
v_component_id        				jafc.jafc_component.component_id%type;
v_title        					  	jafc.jafc_component.title%type;
v_component_desc        		  	jafc.jafc_component.component_desc%type;
v_published_version_number          jafc.jafc_component.published_version_number%type;
v_created_date        				jafc.jafc_component.created_date%type;
v_updated_date        				jafc.jafc_component.updated_date%type;
v_created_by        				jafc.jafc_component.created_by%type;
v_updated_by        				jafc.jafc_component.updated_by%type;
v_is_active        					jafc.jafc_component.is_active%type;
v_is_deleted        				jafc.jafc_component.is_deleted%type;
v_is_published        				jafc.jafc_component.is_published%type;
v_component_guid        			jafc.jafc_component.component_guid%type;

v_sysdate 							 timestamp;

begin

		select current_timestamp
		into   v_sysdate;
		-------------------------------------------------------------
		v_json :=p_json;
		-------------------------------------------------------------
		/***
		get data from json
		***/
		-------------------------------------------------------------
		select 	v_json->'data'->>'component_id',
				v_json->'data'->>'title',
				v_json->'data'->>'component_desc',
				v_json->'data'->>'published_version_number',
				v_json->'data'->>'updated_by',
				v_json->'data'->>'is_active',
				v_json->'data'->>'is_deleted',
				v_json->'data'->>'is_published'
		into            
				v_component_id,
				v_title,
				v_component_desc,
				v_published_version_number,
				v_updated_by,
				v_is_active,
				v_is_deleted,
				v_is_published;
		---------------------------------------------------------------        

		if (v_component_id is null)
		then
			v_component_guid := uuid_generate_v4();	
			v_component_id   := nextval('jafc.seq_jafc_component_id');
            
            v_json 	         := jsonb_set(v_json, '{data,component_id}', v_component_id::text::jsonb, true);
            v_json 	         := jsonb_set(v_json, '{data,guid}', ('"'||v_component_guid||'"')::text::jsonb, true);

			insert into jafc.jafc_component
			(
			component_id,
			title,
			component_desc,
			published_version_number,
			created_date,
			updated_date,
			created_by,
			updated_by,
			is_active,
			is_deleted,
			is_published,
			component_guid
			)    
			values
			(
			v_component_id,
			v_title,
			v_component_desc,
			v_published_version_number,
			v_sysdate,
			v_sysdate,
			v_updated_by,
			v_updated_by,
			v_is_active,
			v_is_deleted,
			v_is_published,
			v_component_guid
			);    
		else
			update jafc.jafc_component
			set title = v_title,
				component_desc = v_component_desc,
				published_version_number = v_published_version_number,
				updated_date = v_sysdate,
				updated_by = v_updated_by,
				is_active = v_is_active,
				is_deleted = v_is_deleted,
				is_published = v_is_published
			where component_id = v_component_id;

		end if;

		p_result := 1;

		p_data := v_json;

end;

$$;


--
