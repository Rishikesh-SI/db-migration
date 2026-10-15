-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_upd_peppo_id(jsonb)
-- Type: FUNCTION

-- Name: lablsg_v1_upd_peppo_id(jsonb); Type: FUNCTION; Schema: lablsg_v1; Owner: -
--

CREATE FUNCTION lablsg_v1.lablsg_v1_upd_peppo_id(p_data jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare

v_peppo_id character varying;
v_user_guid character varying;
v_data numeric;

begin

select p_data->'data'->>'peppo_id',
	   p_data->'data'->>'waf_user_guid'
into
	v_peppo_id,
	v_user_guid;

if exists(select 1 from lablsg_v1.lablsg_v1_web_user
		 where user_guid=v_user_guid) then
		 
		 update lablsg_v1.lablsg_v1_web_user
		set peppo_id = v_peppo_id
		where user_guid=v_user_guid;
		 
		 v_data:=1;
		 
else

		v_data = 0;

end if;

p_result := v_data;
		

end
$$;


--
