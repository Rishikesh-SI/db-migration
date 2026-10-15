-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_ins_upd_template(jsonb)
-- Type: FUNCTION

-- Name: dd_ins_upd_template(jsonb); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_ins_upd_template(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare

v_json 								jsonb;
V_template_id        					dd.dd_template.template_id%TYPE;

V_template_name        				dd.dd_template.template_name%TYPE;
V_template_desc        				dd.dd_template.template_desc%TYPE;
v_page_id							dd.dd_template.page_id%type;
v_layout_id							dd.dd_template.layout_id%type;
v_parent_id							dd.dd_template.parent_id%type;
v_is_inherited							dd.dd_template.is_inherited%type;
V_published_version_number        	dd.dd_template.published_version_number%TYPE;
V_created_date        				dd.dd_template.created_date%TYPE;
V_updated_date        				dd.dd_template.updated_date%TYPE;
V_created_by        				dd.dd_template.created_by%TYPE;
V_updated_by        				dd.dd_template.updated_by%TYPE;
V_is_active        					dd.dd_template.is_active%TYPE;
V_is_deleted        				dd.dd_template.is_deleted%TYPE;
V_is_published        				dd.dd_template.is_published%TYPE;
V_template_guid        				dd.dd_template.template_guid%TYPE;
v_master_id						dd.dd_template.is_master%type;

v_sysdate 							 timestamp;
V_is_master                             numeric;
V_master_template_id                    numeric;
V_template_html        				dd.dd_layout.layout_html%TYPE;

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
		SELECT 	v_json->'data'->>'template_id',
                v_json->'data'->>'template_name',
                v_json->'data'->>'template_desc',
                v_json->'data'->>'published_version_number',
                v_json->'data'->>'updated_by',
                v_json->'data'->>'created_by',
                v_json->'data'->>'is_active',
                v_json->'data'->>'is_deleted',
                v_json->'data'->>'is_published',
                v_json->'data'->>'is_master',
                v_json->'data'->>'page_id',
                v_json->'data'->>'layout_id',
                v_json->'data'->>'is_inherited',
                v_json->'data'->>'parent_id',
                v_json->'data'->>'template_html'

		INTO            
				V_template_id,
                V_template_name,
                V_template_desc,
                V_published_version_number,
                V_updated_by,
                V_created_by,
                V_is_active,
                V_is_deleted,
                V_is_published,
                V_is_master,
                v_page_id,
                V_layout_id,
                v_is_inherited,
                v_parent_id,
                v_template_html;
		---------------------------------------------------------------        

		if (V_template_id is null)
		then
        
			V_template_guid    := uuid_generate_v4();	
			V_template_id      := nextval('dd.seq_dd_template_id');
            v_json 	         := jsonb_set(v_json, '{data,template_id}', V_template_id::text::jsonb, true);
            v_json 	         := jsonb_set(v_json, '{data,guid}', ('"'||V_template_guid||'"')::text::jsonb, true);

			insert into dd.dd_template
			(
			template_id,
                   page_id,
                   template_name,
                   template_desc,
                   layout_id,
                   is_inherited,
                   parent_id,
                   published_version_number,
                   created_date,
                   updated_date,
                   created_by,
                   updated_by,
                   is_active,
                   is_deleted,
                   is_published,
                   template_guid,
                   is_master,
                	template_html
			)    
			values
			(
			V_template_id,
                   v_page_id,
            v_template_name,
            V_template_desc,
                   v_layout_id,
                   v_is_inherited,
                   v_parent_id,
            V_published_version_number,
            v_sysdate,
            v_sysdate,
            V_updated_by,
            V_updated_by,
            V_is_active,
            V_is_deleted,
            V_is_published,
            V_template_guid,
                 V_is_master,
                V_template_html
			);    
		else
        
			update dd.dd_template
            set 	page_id = v_page_id,
                    template_name = V_template_name,
                    template_desc = V_template_desc,
                    layout_id = v_layout_id,
                    is_inherited = v_is_inherited,
                    parent_id = v_parent_id,
                    published_version_number = V_published_version_number,
                    updated_date = v_sysdate,
                    updated_by = V_updated_by,
                    is_active = V_is_active,
                    is_deleted = V_is_deleted,
                    is_published = V_is_published,
                    is_master = V_is_master,
                    template_html = V_template_html
		   where    template_id = V_template_id;

		end if;

		p_result := V_template_id;

		p_data := v_json;

END;

$$;


--
