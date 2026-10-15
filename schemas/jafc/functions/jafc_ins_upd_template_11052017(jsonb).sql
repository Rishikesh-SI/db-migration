-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_ins_upd_template_11052017(jsonb)
-- Type: FUNCTION

-- Name: jafc_ins_upd_template_11052017(jsonb); Type: FUNCTION; Schema: jafc; Owner: -
--

CREATE FUNCTION jafc.jafc_ins_upd_template_11052017(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare

v_json 								jsonb;
v_template_id        					jafc.jafc_template.template_id%type;

v_template_name        				jafc.jafc_template.template_name%type;
v_template_desc        				jafc.jafc_template.template_desc%type;
v_page_id							jafc.jafc_template.page_id%type;
v_layout_id							jafc.jafc_template.layout_id%type;
v_parent_id							jafc.jafc_template.parent_id%type;
v_is_inherited							jafc.jafc_template.is_inherited%type;
v_published_version_number        	jafc.jafc_template.published_version_number%type;
v_created_date        				jafc.jafc_template.created_date%type;
v_updated_date        				jafc.jafc_template.updated_date%type;
v_created_by        				jafc.jafc_template.created_by%type;
v_updated_by        				jafc.jafc_template.updated_by%type;
v_is_active        					jafc.jafc_template.is_active%type;
v_is_deleted        				jafc.jafc_template.is_deleted%type;
v_is_published        				jafc.jafc_template.is_published%type;
v_template_guid        				jafc.jafc_template.template_guid%type;
v_master_id						jafc.jafc_template.is_master%type;

v_sysdate 							 timestamp;
v_is_master                             numeric;
v_master_template_id                    numeric;
v_template_html        				jafc.jafc_layout.layout_html%type;

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
		select 	v_json->'data'->>'template_id',
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

		into            
				v_template_id,
                v_template_name,
                v_template_desc,
                v_published_version_number,
                v_updated_by,
                v_created_by,
                v_is_active,
                v_is_deleted,
                v_is_published,
                v_is_master,
                v_page_id,
                v_layout_id,
                v_is_inherited,
                v_parent_id,
                v_template_html;
		---------------------------------------------------------------        

		if (v_template_id is null)
		then
        
			v_template_guid    := uuid_generate_v4();	
			v_template_id      := nextval('jafc.seq_jafc_template_id');
            v_json 	         := jsonb_set(v_json, '{data,template_id}', v_template_id::text::jsonb, true);
            v_json 	         := jsonb_set(v_json, '{data,guid}', ('"'||v_template_guid||'"')::text::jsonb, true);

			insert into jafc.jafc_template
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
			v_template_id,
                   v_page_id,
            v_template_name,
            v_template_desc,
                   v_layout_id,
                   v_is_inherited,
                   v_parent_id,
            v_published_version_number,
            v_sysdate,
            v_sysdate,
            v_updated_by,
            v_updated_by,
            v_is_active,
            v_is_deleted,
            v_is_published,
            v_template_guid,
                 v_is_master,
                v_template_html
			);    
		else
        
			update jafc.jafc_template
            set 	page_id = v_page_id,
                    template_name = v_template_name,
                    template_desc = v_template_desc,
                    layout_id = v_layout_id,
                    is_inherited = v_is_inherited,
                    parent_id = v_parent_id,
                    published_version_number = v_published_version_number,
                    updated_date = v_sysdate,
                    updated_by = v_updated_by,
                    is_active = v_is_active,
                    is_deleted = v_is_deleted,
                    is_published = v_is_published,
                    is_master = v_is_master,
                    template_html = v_template_html
		   where    template_id = v_template_id;

		end if;

		p_result := v_template_id;

		p_data := v_json;

end;

$$;


--
