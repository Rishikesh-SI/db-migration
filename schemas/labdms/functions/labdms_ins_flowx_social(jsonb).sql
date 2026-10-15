-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_ins_flowx_social(jsonb)
-- Type: FUNCTION

-- Name: labdms_ins_flowx_social(jsonb); Type: FUNCTION; Schema: labdms; Owner: -
--

CREATE FUNCTION labdms.labdms_ins_flowx_social(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
 
declare

	   v_cnt numeric;
	   v_id numeric;
	   v_likescount numeric;
	   v_publisher varchar(1000);
	   v_reference text;
	   v_retweetcount numeric;
	   v_text text;
	   v_orignal_post jsonb;
	   v_profile_images text;
	   v_user_desc text;
	   v_user_id text;
	   v_user_verified text;
	   v_screen_name text;
	   v_user_name text;
	   v_reply jsonb;
	   v_hashtags jsonb;
	   v_mentions jsonb;
	   v_targetmedia jsonb;
	   v_links jsonb;
	   v_creation_date text;
	   v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	   v_json jsonb;
	   v_source_object_id text;
begin

p_json:=p_json->'data';

for v_json in select * from jsonb_array_elements(p_json::jsonb)
loop
select v_json->>'id',
	   v_json->>'likescount',
	   v_json->>'publisher',
	   v_json->>'reference',
	   v_json->>'retweetcount',
	   v_json->>'text',
	   v_json->'orignal_post',
	   v_json->>'profile_images',
	   v_json->>'user_desc',
	   v_json->>'user_id',
	   v_json->>'user_verified',
	   v_json->>'screen_name',
	   v_json->>'user_name',
	   v_json->'reply',
	   v_json->'hashtags',
	   v_json->'mentions',
	   v_json->'targetmedia',
	   v_json->'links',
	   v_json->>'creation_date'
into 	   
	   v_id,
	   v_likescount,
	   v_publisher,
	   v_reference,
	   v_retweetcount,
	   v_text,
	   v_orignal_post,
	   v_profile_images,
	   v_user_desc,
	   v_user_id,
	   v_user_verified,
	   v_screen_name,
	   v_user_name,
	   v_reply,
	   v_hashtags,
	   v_mentions,
	   v_targetmedia,
	   v_links,
	   v_creation_date
;	   

if v_id is not null then 

begin
    select 1 into strict v_cnt 
    from labdms.labdms_flowx_social
	where id=v_id;

p_result:=2;
exception when no_data_found then 

	
    select  source_object_id into v_source_object_id
	from labdms.labdms_flowix_teams
	where lower(scream_name)=lower(v_screen_name);
	
    insert into labdms.labdms_flowx_social
	select nextval('labdms.seq_flowx_social_id'),v_id,v_likescount,v_publisher,v_reference,v_retweetcount,v_text,
	     v_orignal_post,v_profile_images,v_user_desc,v_user_id,v_user_verified, v_screen_name,v_user_name,v_reply,
	   v_creation_date,v_current_timestamp,v_hashtags,v_mentions,v_targetmedia,v_links,v_json,v_source_object_id
	   
;	   

p_result:=1;

end ;
end if;

end loop;
end;

 
$$;


--
