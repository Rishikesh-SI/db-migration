-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_ins_upd_component(jsonb)
-- Type: FUNCTION

-- Name: u17wc_ins_upd_component(jsonb); Type: FUNCTION; Schema: u17wc; Owner: -
--

CREATE FUNCTION u17wc.u17wc_ins_upd_component(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$     

declare

v_json 								jsonb;
V_component_id        				u17wc.u17wc_component.component_id%TYPE;
V_title        					  	u17wc.u17wc_component.title%TYPE;
V_component_desc        		  	u17wc.u17wc_component.component_desc%TYPE;
V_published_version_number          u17wc.u17wc_component.published_version_number%TYPE;
V_created_date        				u17wc.u17wc_component.created_date%TYPE;
V_updated_date        				u17wc.u17wc_component.updated_date%TYPE;
V_created_by        				u17wc.u17wc_component.created_by%TYPE;
V_updated_by        				u17wc.u17wc_component.updated_by%TYPE;
V_is_active        					u17wc.u17wc_component.is_active%TYPE;
V_is_deleted        				u17wc.u17wc_component.is_deleted%TYPE;
V_is_published        				u17wc.u17wc_component.is_published%TYPE;
V_component_guid        			u17wc.u17wc_component.component_guid%TYPE;

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
			V_component_id   := nextval('u17wc.seq_u17wc_component_id');
            
            v_json 	         := jsonb_set(v_json, '{data,component_id}', V_component_id::text::jsonb, true);
            v_json 	         := jsonb_set(v_json, '{data,guid}', ('"'||V_component_guid||'"')::text::jsonb, true);

			insert into u17wc.u17wc_component
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
			update u17wc.u17wc_component
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
