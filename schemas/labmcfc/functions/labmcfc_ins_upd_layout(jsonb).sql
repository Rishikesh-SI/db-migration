-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: labmcfc_ins_upd_layout(jsonb)
-- Type: FUNCTION

-- Name: labmcfc_ins_upd_layout(jsonb); Type: FUNCTION; Schema: labmcfc; Owner: -
--

CREATE FUNCTION labmcfc.labmcfc_ins_upd_layout(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare

v_json 								jsonb;
V_layout_id        					labmcfc.labmcfc_layout.layout_id%TYPE;
V_layout_html        				labmcfc.labmcfc_layout.layout_html%TYPE;
V_layout_name        				labmcfc.labmcfc_layout.layout_name%TYPE;
V_layout_desc        				labmcfc.labmcfc_layout.layout_desc%TYPE;
V_published_version_number        	labmcfc.labmcfc_layout.published_version_number%TYPE:=1;
V_created_date        				labmcfc.labmcfc_layout.created_date%TYPE;
V_updated_date        				labmcfc.labmcfc_layout.updated_date%TYPE;
V_created_by        				labmcfc.labmcfc_layout.created_by%TYPE;
V_updated_by        				labmcfc.labmcfc_layout.updated_by%TYPE;
V_is_active        					labmcfc.labmcfc_layout.is_active%TYPE;
V_is_deleted        				labmcfc.labmcfc_layout.is_deleted%TYPE;
V_is_published        				labmcfc.labmcfc_layout.is_published%TYPE;
V_layout_guid        				labmcfc.labmcfc_layout.layout_guid%TYPE;

v_sysdate 							 timestamp;
V_is_master                             numeric;
V_master_template_id                    numeric;
V_version_number		labmcfc.labmcfc_layout.published_version_number%TYPE;
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
        RAISE NOTICE '%',v_json->'data'->>'layout_id';
		SELECT 	v_json->'data'->>'layout_id',
                v_json->'data'->>'layout_html',
                v_json->'data'->>'layout_name',
                v_json->'data'->>'layout_desc',
                v_json->'data'->>'version_number',
                v_json->'data'->>'updated_by',
                v_json->'data'->>'status',
                v_json->'data'->>'is_master',
                v_json->'data'->>'master_template_id'

		INTO            
				V_layout_id,
                V_layout_html,
                V_layout_name,
                V_layout_desc,
                V_version_number,
                V_updated_by,
                V_is_published,
                V_is_master,
                V_master_template_id;
		---------------------------------------------------------------        
RAISE NOTICE '%',V_layout_html;
		if (V_layout_id is null)
		then
        
			V_layout_guid    := uuid_generate_v4();	
			V_layout_id      := nextval('labmcfc.seq_labmcfc_layout_id');
            v_json 	         := jsonb_set(v_json, '{data,layout_id}', V_layout_id::text::jsonb, true);
            v_json 	         := jsonb_set(v_json, '{data,guid}', ('"'||V_layout_guid||'"')::text::jsonb, true);

			insert into labmcfc.labmcfc_LAYOUT
			(
			layout_id,
            layout_html,
            layout_name,
            layout_desc,
            published_version_number,
            created_date,
            updated_date,
            created_by,
            updated_by,
            is_active,
            is_deleted,
            is_published,
            layout_guid,
		  is_master,
    		  master_template_id
			)    
			values
			(
			V_layout_id,
            V_layout_html,
            V_layout_name,
            V_layout_desc,
            V_published_version_number,
            v_sysdate,
            v_sysdate,
            V_updated_by,
            V_updated_by,
            1,
            0,
            V_is_published,
            V_layout_guid,
                 V_is_master,
                V_master_template_id  
			);    
		else
        
			update labmcfc.labmcfc_layout
            set 	layout_html = V_layout_html,
                    layout_name = V_layout_name,
                    layout_desc = V_layout_desc,
                    published_version_number = V_published_version_number,
                    updated_date = v_sysdate,
                    updated_by = V_updated_by,
                    is_published = V_is_published,
                    is_master = V_is_master,
                    master_template_id = V_master_template_id
		   where    layout_id = V_layout_id;

		end if;

		p_result := 1;

		p_data := v_json;

END;

 $$;


--
