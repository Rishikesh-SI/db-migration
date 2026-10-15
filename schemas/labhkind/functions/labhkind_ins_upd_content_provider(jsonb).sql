-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_ins_upd_content_provider(jsonb)
-- Type: FUNCTION

-- Name: labhkind_ins_upd_content_provider(jsonb); Type: FUNCTION; Schema: labhkind; Owner: -
--

CREATE FUNCTION labhkind.labhkind_ins_upd_content_provider(p_json jsonb, OUT p_out numeric, OUT p_content_provider_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
v_content_provider_id numeric;
v_content_provider_name varchar(500);
v_is_active numeric;
v_is_deleted numeric;
begin
select p_json->>'content_provider_id',
       p_json->>'content_provider_name',
	   p_json->>'is_active',
	   p_json->>'is_deleted'

into 
v_content_provider_id,
v_content_provider_name,
v_is_active,
v_is_deleted;

if v_content_provider_id is null then
if not exists(select 1 from labhkind.labhkind_content_provider
			 where upper(content_provider_name)=upper(v_content_provider_name))
			 then
  INSERT INTO labhkind.labhkind_content_provider(
	content_provider_id, content_provider_name, created_date, updated_date, created_by, updated_by, is_active, is_deleted, content_provider_display_name, content_provider_desc, is_published, content_provider_guid, copyright_text)
	 select nextval( 'labhkind.seq_labhkind_content_provider_id'), 
	 v_content_provider_name, current_timestamp, current_timestamp,
	 1, 1, 1, 0, v_content_provider_name, 
	 v_content_provider_name, 1,  uuid_generate_v4(), null;
	 
	p_out:=1;
	else
	p_out:=2;

end if;

else

 update labhkind.labhkind_content_provider
 set content_provider_name=case when v_content_provider_name is not null 
                           then v_content_provider_name
						   else content_provider_name end,
	 is_active=	case when v_is_active is not null 
                           then v_is_active
						   else is_active end,	
	is_deleted=	case when v_is_deleted is not null 
                           then v_is_deleted
						   else is_deleted end					   
 where content_provider_id=v_content_provider_id;
						   
 
p_out:=1;

 
end if;
if p_out=1 then
p_content_provider_json:=p_json;
end if;

exception when others then
p_out:=-1;

end;
$$;


--
