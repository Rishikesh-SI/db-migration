-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_ins_upd_jersey_request(jsonb)
-- Type: FUNCTION

-- Name: dd_ins_upd_jersey_request(jsonb); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_ins_upd_jersey_request(p_json jsonb, OUT p_out numeric, OUT p_req_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare 
 v_user_guid text;
 v_user_id numeric;
 v_email_id text;
 v_favourite_player varchar(500);
 v_jersey_number numeric;
 v_user_name varchar(500);
 begin
select p_json ->>'user_guid',
  p_json ->> 'jersey_number',
  p_json ->> 'favourite_player',
  p_json ->> 'user_name'
  into v_user_guid,
  v_jersey_number,
  v_favourite_player,
  v_user_name;
  
  select user_id,email_id
  from dd.dd_web_user
  where user_guid=v_user_guid
  into v_user_id,v_email_id;
  
insert into   dd.dd_user_jersey_request
(jersey_request_id,
user_id,
email_id,
jersey_number,
favorite_player,
player_name)
select nextval('dd.dd_user_jersey_request_seq'),
v_user_id,
v_email_id,
v_jersey_number,
v_favourite_player,
v_user_name;

  p_out:=1;
  
  select row_to_json(row)
		from (
			select v_user_guid as user_guid,
			v_jersey_number as jersey_number,
			  v_favourite_player as favourite_player,
			v_user_name as user_name
			)as row
		into p_req_json;	
  
exception
when no_data_found then
p_out:=2;
when others then
p_out:=-1;
end;
$$;


--
