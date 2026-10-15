-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: labetpl_ins_upd_content_type(jsonb)
-- Type: FUNCTION

-- Name: labetpl_ins_upd_content_type(jsonb); Type: FUNCTION; Schema: labetpl; Owner: -
--

CREATE FUNCTION labetpl.labetpl_ins_upd_content_type(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
 		 v_content_type_id numeric;
           v_contenttype character varying;
		   v_desc character varying;
		   v_component_id numeric;
		   v_custom_meta_info jsonb;
		   v_created_by numeric;
		   v_updated_by numeric;
		   v_is_publish numeric;
		   v_status numeric;
		   v_is_active numeric;
		   v_is_deleted numeric;
		   v_content_type_fields jsonb;	
		   v_content_field jsonb;
		   v_created_date timestamp;  
		   v_updated_date timestamp;  
	       v_assettypeid numeric;
		   v_content_field_id numeric;
           v_setting_json jsonb;
      	   v_name character varying;
		   v_data_type character varying;
		   v_default_value character varying;
	       v_type character varying;
	       v_label character varying;
	       v_showinlisting boolean;
   		   v_createdby numeric;
		   v_updatedby numeric;
			v_json jsonb;
			v_order_no numeric;	
			v_is_required boolean;
begin
	
	v_json:= p_json;
	
	select v_json->'data'->>'content_type_id',
           v_json->'data'->>'contenttype',
		   v_json->'data'->>'description',
		   v_json->'data'->>'component_id',
		   v_json->'data'->>'custom_meta_info',
		   v_json->'data'->>'created_by',
		   v_json->'data'->>'updated_by',
		   v_json->'data'->>'is_publish',
		   v_json->'data'->>'status',
		   v_json->'data'->>'is_active',
		   v_json->'data'->>'is_deleted',
		   v_json->'data'->'content_type_fields'
	into   v_content_type_id,
           v_contenttype,
		   v_desc,
		   v_component_id,
		   v_custom_meta_info,
		   v_createdby,
		   v_updatedby,
		   v_is_publish,
		   v_status,
		   v_is_active,
		   v_is_deleted,
		   v_content_type_fields;
  
  		raise notice 'v_content_type_fields %',v_content_type_fields;
    	v_created_date:=current_timestamp at time zone 'utc';
		v_updated_date:=current_timestamp at time zone 'utc';
       
		if v_content_type_id is null then

            v_assettypeid := nextval('labetpl.seq_labetpl_asset_type_id');
				
			insert into labetpl.labetpl_asset_type(asset_type_id, title, asset_desc, created_date, updated_date,
                                            created_by, updated_by, is_active, is_deleted,asset_type_guid,is_content_type,component_id,custom_meta_info,is_publish,status)
			values(v_assettypeid, v_contenttype, v_desc, v_created_date, v_updated_date, v_createdby, v_updatedby,1,0,uuid_generate_v4(),1,
				   v_component_id,v_custom_meta_info,v_is_publish,v_status);
			               
				for v_content_field in select * from jsonb_array_elements(v_content_type_fields)
				loop
                	
                    select v_content_field->>'content_field_id',
                    	   v_content_field->>'settingjson',
                           v_content_field->>'field_name',
						   v_content_field->>'field_data_type',
						   v_content_field->>'field_defaultvalue',
						   v_content_field->>'field_type',
						   v_content_field->>'field_label',
						   v_content_field->>'show_in_listing_json',
						   v_content_field->>'is_active',
						   v_content_field->>'is_deleted',
						   v_content_field->>'created_by',
						   v_content_field->>'updated_by',
						   v_content_field->>'order_no',
						   v_content_field->>'is_required'
					into   v_content_field_id,
                    	   v_setting_json,
                           v_name,
						   v_data_type,
						   v_default_value,
						   v_type,
						   v_label,
						   v_showinlisting,
						   v_is_active,
						   v_is_deleted,
				   		   v_createdby,
						   v_updatedby,
						   v_order_no,
						   v_is_required;
						raise notice 'field_data_type %' ,v_data_type;  
					
			insert into labetpl.labetpl_content_type_fields(content_type_field_id, content_type_id, field_name, field_data_type, field_defaultvalue, field_type, field_label, 
                                                        show_in_listing_json, is_active, is_deleted, created_date, updated_date, created_by, updated_by, order_no, settingjson, is_required)
			values(nextval('labetpl.seq_labetpl_content_type_field_id'),v_assettypeid, v_name, v_data_type, v_default_value,v_type,v_label,v_showinlisting,1,0,v_created_date,
				   v_updated_date, v_createdby, v_updatedby,v_order_no,v_setting_json,v_is_required);
				   
			end loop;	   
			
 			p_result:= 1;
			
			elsif exists (select 1 from labetpl.labetpl_asset_type where asset_type_id=v_content_type_id) then
								raise notice 'v_createdby %',v_createdby;

			update labetpl.labetpl_asset_type
			set  title = v_contenttype, asset_desc = v_desc,updated_date = v_updated_date,
			created_by = v_createdby, updated_by = v_updatedby, is_active = v_is_active, is_deleted = v_is_deleted,
			component_id = v_component_id,custom_meta_info = v_custom_meta_info,is_publish = v_is_publish,status = v_status
			where asset_type_id=v_content_type_id;

		   for v_content_field in select * from jsonb_array_elements(v_content_type_fields)
				loop
                	
                    select v_content_field->>'content_field_id',
                    	   v_content_field->>'settingjson',
                           v_content_field->>'field_name',
						   v_content_field->>'field_data_type',
						   v_content_field->>'field_defaultvalue',
						   v_content_field->>'field_type',
						   v_content_field->>'field_label',
						   v_content_field->>'show_in_listing_json',
						   v_content_field->>'is_active',
						   v_content_field->>'is_deleted',
						   v_content_field->>'order_no',
						   v_content_field->>'is_required'
					into   v_content_field_id,
                    	   v_setting_json,
                           v_name,
						   v_data_type,
						   v_default_value,
						   v_type,
						   v_label,
						   v_showinlisting,
						   v_is_active,
						   v_is_deleted,
						   v_order_no,
						   v_is_required;

-- 					raise notice 'v_name %',v_name;
-- 					raise notice 'v_content_field_id %',v_content_field_id;
-- 					raise notice 'v_content_type_id %',v_content_type_id;
					
				if v_content_field_id is not null then 
					raise notice 'v_content_field_id !=0 %',v_content_field_id;
					update labetpl.labetpl_content_type_fields
					set field_name = v_name, field_data_type = v_data_type, field_defaultvalue = v_default_value, field_type = v_type, field_label = v_label, show_in_listing_json = v_showinlisting,
					is_active = v_is_active, is_deleted = v_is_deleted,updated_date = v_updated_date, created_by = v_createdby, updated_by = v_updatedby , settingjson = v_setting_json,order_no = v_order_no,
					is_required = v_is_required
					where content_type_id = v_content_type_id
					and content_type_field_id = v_content_field_id;
					
				elsif v_content_field_id is null then 
				raise notice 'v_content_field_id=0 %',v_content_field_id;	
				
			insert into labetpl.labetpl_content_type_fields(content_type_field_id, content_type_id, field_name, field_data_type, field_defaultvalue, field_type, field_label, 
                                                        show_in_listing_json, is_active, is_deleted, created_date, updated_date, created_by, updated_by, order_no, settingjson, is_required)
			values(nextval('labetpl.seq_labetpl_content_type_field_id'),v_content_type_id, v_name, v_data_type, v_default_value,v_type,v_label,v_showinlisting,1,0,v_created_date,
				   v_updated_date, v_createdby, v_updatedby,v_order_no,v_setting_json,v_is_required);
				   			
 			p_result:= 1;
					
			end if;	
				end loop;
				
				p_result:= 1;
				
				elsif not exists (select 1 from labetpl.labetpl_asset_type where asset_type_id=v_content_type_id) then
				
					
				p_result:= -1;
				
				end if;
		
	if p_result = 1 then
    	
        p_data := v_json;
        
	elsif p_result = -1 then
		
		p_data := '{"message":"NO DATA FOUND"}';
	
	end if;
    
/*exception
	
	when others then
		p_result := -1;*/
	
end;
$$;


--
