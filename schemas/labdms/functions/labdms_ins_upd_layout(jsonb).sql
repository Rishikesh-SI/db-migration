-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_ins_upd_layout(jsonb)
-- Type: FUNCTION

-- Name: labdms_ins_upd_layout(jsonb); Type: FUNCTION; Schema: labdms; Owner: -
--

CREATE FUNCTION labdms.labdms_ins_upd_layout(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare

v_json 								jsonb;
v_layout_id        					labdms.labdms_layout.layout_id%type;
v_layout_html        				labdms.labdms_layout.layout_html%type;
v_layout_name        				labdms.labdms_layout.layout_name%type;
v_layout_desc        				labdms.labdms_layout.layout_desc%type;
v_published_version_number        	labdms.labdms_layout.published_version_number%type:=1;
v_created_date        				labdms.labdms_layout.created_date%type;
v_updated_date        				labdms.labdms_layout.updated_date%type;
v_created_by        				labdms.labdms_layout.created_by%type;
v_updated_by        				labdms.labdms_layout.updated_by%type;
v_is_active        					labdms.labdms_layout.is_active%type;
v_is_deleted        				labdms.labdms_layout.is_deleted%type;
v_is_published        				labdms.labdms_layout.is_published%type;
v_layout_guid        				labdms.labdms_layout.layout_guid%type;

v_sysdate 							 timestamp;
v_is_master                             numeric;
v_master_template_id                    numeric;
v_version_number		labdms.labdms_layout.published_version_number%type;
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
        raise notice '%',v_json->'data'->>'layout_id';
		select 	v_json->'data'->>'layout_id',
                v_json->'data'->>'layout_html',
                v_json->'data'->>'layout_name',
                v_json->'data'->>'layout_desc',
                v_json->'data'->>'version_number',
                v_json->'data'->>'updated_by',
                v_json->'data'->>'status',
                v_json->'data'->>'is_master',
                v_json->'data'->>'master_template_id'

		into            
				v_layout_id,
                v_layout_html,
                v_layout_name,
                v_layout_desc,
                v_version_number,
                v_updated_by,
                v_is_published,
                v_is_master,
                v_master_template_id;
		---------------------------------------------------------------        
raise notice '%',v_layout_html;
		if (v_layout_id is null)
		then
        
			v_layout_guid    := uuid_generate_v4();	
			v_layout_id      := nextval('labdms.seq_labdms_layout_id');
            v_json 	         := jsonb_set(v_json, '{data,layout_id}', v_layout_id::text::jsonb, true);
            v_json 	         := jsonb_set(v_json, '{data,guid}', ('"'||v_layout_guid||'"')::text::jsonb, true);

			insert into labdms.labdms_layout
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
			v_layout_id,
            v_layout_html,
            v_layout_name,
            v_layout_desc,
            v_published_version_number,
            v_sysdate,
            v_sysdate,
            v_updated_by,
            v_updated_by,
            1,
            0,
            v_is_published,
            v_layout_guid,
                 v_is_master,
                v_master_template_id  
			);    
		else
        
			update labdms.labdms_layout
            set 	layout_html = v_layout_html,
                    layout_name = v_layout_name,
                    layout_desc = v_layout_desc,
                    published_version_number = v_published_version_number,
                    updated_date = v_sysdate,
                    updated_by = v_updated_by,
                    is_published = v_is_published,
                    is_master = v_is_master,
                    master_template_id = v_master_template_id
		   where    layout_id = v_layout_id;

		end if;

		p_result := 1;

		p_data := v_json;

end;

 $$;


--
