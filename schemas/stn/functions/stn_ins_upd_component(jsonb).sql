-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_ins_upd_component(jsonb)
-- Type: FUNCTION

-- Name: stn_ins_upd_component(jsonb); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_ins_upd_component(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare

v_json 								jsonb;
V_component_id        				stn.stn_component.component_id%TYPE;
V_title        					  	stn.stn_component.title%TYPE;
V_component_desc        		  	stn.stn_component.component_desc%TYPE;
V_published_version_number          stn.stn_component.published_version_number%TYPE;
V_created_date        				stn.stn_component.created_date%TYPE;
V_updated_date        				stn.stn_component.updated_date%TYPE;
V_created_by        				stn.stn_component.created_by%TYPE;
V_updated_by        				stn.stn_component.updated_by%TYPE;
V_is_active        					stn.stn_component.is_active%TYPE;
V_is_deleted        				stn.stn_component.is_deleted%TYPE;
V_is_published        				stn.stn_component.is_published%TYPE;
V_component_guid        			stn.stn_component.component_guid%TYPE;

v_sysdate 							 timestamp;

BEGIN

		select current_timestamp
		into   v_sysdate;
		-------------------------------------------------------------
		v_json :=p_json;
		-------------------------------------------------------------
		/***
		Get data from JSON
		***/
		-------------------------------------------------------------
		SELECT 	v_json->'data'->>'component_id',
				v_json->'data'->>'title',
				v_json->'data'->>'component_desc',
				v_json->'data'->>'published_version_number',
				v_json->'data'->>'updated_by',
				v_json->'data'->>'is_active',
				v_json->'data'->>'is_deleted',
				v_json->'data'->>'is_published'
		INTO            
				V_component_id,
				V_title,
				V_component_desc,
				V_published_version_number,
				V_updated_by,
				V_is_active,
				V_is_deleted,
				V_is_published;
		---------------------------------------------------------------        

		if (V_component_id is null)
		then
			V_component_guid := uuid_generate_v4();	
			V_component_id   := nextval('stn.seq_stn_component_id');
            
            v_json 	         := jsonb_set(v_json, '{data,component_id}', V_component_id::text::jsonb, true);
            v_json 	         := jsonb_set(v_json, '{data,guid}', ('"'||V_component_guid||'"')::text::jsonb, true);

			insert into stn.stn_component
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
			V_component_id,
			V_title,
			V_component_desc,
			V_published_version_number,
			v_sysdate,
			v_sysdate,
			V_updated_by,
			V_updated_by,
			V_is_active,
			V_is_deleted,
			V_is_published,
			V_component_guid
			);    
		else
			update stn.stn_component
			set title = V_title,
				component_desc = V_component_desc,
				published_version_number = V_published_version_number,
				updated_date = v_sysdate,
				updated_by = V_updated_by,
				is_active = V_is_active,
				is_deleted = V_is_deleted,
				is_published = V_is_published
			where component_id = V_component_id;

		end if;

		p_result := 1;

		p_data := v_json;

END;

$$;


--
