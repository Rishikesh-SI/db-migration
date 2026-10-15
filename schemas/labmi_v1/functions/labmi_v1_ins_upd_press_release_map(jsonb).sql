-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_ins_upd_press_release_map(jsonb)
-- Type: FUNCTION

-- Name: labmi_v1_ins_upd_press_release_map(jsonb); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_ins_upd_press_release_map(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare 

v_json							jsonb;
v_attachments                    jsonb;
v_sysdate						timestamp;

v_press_release_map_id numeric;
v_press_release_id numeric;
v_title varchar(2000);
v_short_title varchar(2000);
v_desc text;
v_lang_id numeric;
v_lang_name varchar(2000);

v_status numeric;
v_published_date timestamp;
v_updated_by numeric;

v_guid text;

v_image_id numeric;
v_is_cover numeric;
v_image_name text;
v_image_path text;

/*--sample json 
{
  "data": {
    "press_release_id": "",
    "press_release_map_id":"",
    "title": "1",
    "short_title": "1",
    "desc": "1909",
    "lang_id": "",
    "lang_name": "",
    "updated_by":"",
    "published_date":"",
	"status":"",
    "attachments": [
      {
        "file_id": "11",
        "file_name": "test.pdf",
        "file_path": "ed/2e/44",
        "file_size": "24kb",
        "asset_type_id": "26",
        "file_type": "1"
      }
    ]
  }
}
*/

begin
       select current_timestamp at time zone 'utc'
       into   v_sysdate;  

      -------------------------------------------------------
      
      v_json := p_json;
      -------------------------------------------------------
select  v_json->'data'->>'press_release_map_id',
        v_json->'data'->>'press_release_id',
		v_json->'data'->>'title',
		v_json->'data'->>'short_title',
		v_json->'data'->>'desc',
		v_json->'data'->>'lang_id',
		v_json->'data'->>'lang_name',
		v_json->'data'->>'status',
		v_json->'data'->>'published_date',	
		v_json->'data'->>'updated_by',
		v_json->'data'->'attachments'
		
into    v_press_release_map_id,
		v_press_release_id,
		v_title,
		v_short_title,
		v_desc,
		v_lang_id,
		v_lang_name,
		v_status,
		v_published_date,
		v_updated_by ,
		v_attachments
;

if v_press_release_map_id is null then 
        
		v_press_release_map_id :=nextval('labmi_v1.seq_labmi_v1_press_release_map_id');
	  --  v_guid := uuid_generate_v4();
		v_json := jsonb_set(v_json, '{data,press_release_map_id}', v_press_release_map_id::text::jsonb, true);
	  --  v_json := jsonb_set(v_json, '{data,guid}', ('"'||v_guid||'"')::text::jsonb, true);
		v_published_date:=coalesce(v_published_date,v_sysdate);
			
			--select * from labmi_v1.labmi_v1_press_release_map
			
		insert into labmi_v1.labmi_v1_press_release_map
		 (	press_release_map_id,
			press_release_id,
			title,
		    short_title,
		 	description,
		  	lang_id,
		  	lang_name,
		  	attachments,
	      	is_active,
		  	is_deleted,
		  	is_published,
		  	created_date ,
		    updated_date,
		    published_date
		    )
		values (v_press_release_map_id,
				v_press_release_id,
				v_title,
				v_short_title,
				v_desc,
				v_lang_id,
				v_lang_name,
				v_attachments,
				1,
				0,
				v_status,
				v_sysdate,
				v_sysdate,
				v_published_date
				);
else 

   update labmi_v1.labmi_v1_press_release_map
   set 
       title=v_title,
       is_published=v_status,
	   short_title=v_short_title,
	   description=v_desc,
	   updated_date=v_sysdate,
	   lang_id=v_lang_id,
	   lang_name=v_lang_name,
	   attachments=v_attachments,
	   press_release_id=v_press_release_id,
	   published_date=v_published_date
   where press_release_map_id=v_press_release_map_id
   ;
    

end if ;

p_result=1;
p_data=v_json;

end ;

$$;


--
