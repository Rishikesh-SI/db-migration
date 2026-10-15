-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_get_usersubmit_contest_detail(jsonb)
-- Type: FUNCTION

-- Name: labgsoc_get_usersubmit_contest_detail(jsonb); Type: FUNCTION; Schema: labgsoc; Owner: -
--

CREATE FUNCTION labgsoc.labgsoc_get_usersubmit_contest_detail(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare

v_module text;
v_user_guid character varying;
v_datajson jsonb;
v_user_id numeric;
v_contest_id numeric;
v_title_alias text;
begin
/*
{
    "module": "luckydraw",
    "user_guid":""
}
*/

 select    p_json->>'contestid',
		   p_json->>'user_guid'
into 
	v_contest_id,
	v_user_guid;

  
select user_id from labgsoc.labgsoc_web_user where user_guid = v_user_guid into v_user_id;

raise notice 'v_user_id %' , v_user_id;

--select contest_id from labgsoc.labgsoc_contest where title_alias = v_module  into v_contest_id;

--select contest_id from labgsoc.labgsoc_contest where title_alias = v_module  into v_contest_id;

if not exists (select 1 from labgsoc.labgsoc_user_contest_response where contest_id = v_contest_id and user_id =v_user_id)
	then
 
		 p_data:='{
					"data": {
					"status":"1",
					"message":"Not Played Contest"
					}
					}';
        
		
	else  
		  p_data:='{
						"data": {
						"status":"0",
						"message":"Played Contest"
						}
						}';	

		 
	
	end if;

	
end;
$$;


--
