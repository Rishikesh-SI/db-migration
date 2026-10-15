-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_ins_fan_wall(jsonb)
-- Type: FUNCTION

-- Name: isl_ins_fan_wall(jsonb); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_ins_fan_wall(p_user_json jsonb, OUT p_user_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
/*p_user_json jsonb := '{
 "data": {
"team_id": 1,
"match_id": 1,
"email_id": "BF4mEh2cM1Ihs1qdhM6/SfRgPecas/Zg/SEm5FTmTKkj/py4P/SNWJ40BPSuAbAEH9gZQfYv73Oz7B3PaOWZpw==",
"mobile_no": "IEl0lzTR7nphl+xWiRRdj5eec3OGJHIiWpXr/W5Xox4=",
"name": "NShL31InUxwqDCxobKqjQbIlnoseIgLWPSOREsuB4ro=",
"user_guid": "aab6e6a2-51ba-4ed4-9eab-d9940197df63"
 }
}';*/
v_user_guid character varying(250);
v_team_id numeric;
v_match_id numeric;
v_count numeric;
v_user_data jsonb;
v_email_id character varying(1000);
v_mobile_no character varying(1000);
v_name character varying(1000);
v_country_code numeric;
v_time_1 timestamp;
v_time_2 timestamp;
v_time_count numeric;
begin

select p_user_json->'data'->>'user_guid',
  p_user_json->'data'->>'team_id',
  p_user_json->'data'->>'match_id',
  p_user_json->'data'->>'email_id',
  p_user_json->'data'->>'mobile_no',
  p_user_json->'data'->>'name',
  p_user_json->'data'->>'country_code'
 
into  v_user_guid,
 v_team_id,
 v_match_id,
 v_email_id,
 v_mobile_no,
 v_name,
 v_country_code;
 
v_email_id := case v_email_id when '' then null else v_email_id end;  
v_mobile_no := case v_mobile_no when '' then null else v_mobile_no end;
v_name := case v_name when '' then null else v_name end;

if exists (select 1 from isl.isl_web_user
 where user_guid = v_user_guid and is_active=1) then
 
select max(registered_date) into  v_time_1 from isl.isl_fan_wall
where user_guid = v_user_guid
and  registered_date <> (select registered_date from isl.isl_fan_wall
   where user_guid = v_user_guid
   order by registered_date desc
                   limit 1);
 
select max(registered_date) into  v_time_2 from isl.isl_fan_wall
where user_guid = v_user_guid;

SELECT EXTRACT(EPOCH FROM (v_time_2 - v_time_1)) into v_time_count ;

select count(1) into v_count from isl.isl_fan_wall
where team_id = v_team_id and match_id = v_match_id;

raise notice '%,%',v_time_2,v_time_count;

if v_count < 1000 then

if ((v_time_2 + '1 hour'::interval > current_timestamp at time zone 'utc') and
coalesce(v_time_count,0) > 3600) or
(v_time_2 + '1 hour'::interval < current_timestamp at time zone 'utc')
or (v_time_2 is null or v_time_count is null ) then

if not exists (select 1  from isl.isl_fan_wall
 where team_id = v_team_id and match_id = v_match_id and user_guid = v_user_guid) then

insert into isl.isl_fan_wall(user_guid,team_id,match_id,registered_date)
values(v_user_guid,v_team_id,v_match_id,current_timestamp at time zone 'utc');

v_user_data := '{
"status" : 1,
"message" : "Registrated Succesfully"
}';  

else

v_user_data := '{
"status" : 2,
"message" : "User already Registrated "
}';

end if;

else
   
v_user_data := '{
"status" : 3,
"message" : "Try after 1 hour"
}';

end  if ;

else

v_user_data := '{
"status" : 0,
"message" : "Registration already full"
}';

end if;

 update isl.isl_web_user
 set  email_id = coalesce (v_email_id,email_id) ,
    upper_email_id = coalesce (v_email_id,upper_email_id),
  mobile_no = coalesce (v_mobile_no,mobile_no),
  country_code = coalesce (v_country_code,country_code),
  user_full_name = coalesce (v_name,user_full_name)
 where  user_guid = v_user_guid ;
/*
if (v_email_id is not null ) then

-- if not exists(select 1 from isl.isl_web_user where
-- email_id = v_email_id  and is_active =1) then

update isl.isl_web_user
set  email_id = v_email_id ,upper_email_id = v_email_id
where  user_guid = v_user_guid ;

-- end if;

end if;

 if (v_mobile_no is not null ) then

-- if not exists(select 1 from isl.isl_web_user where
-- mobile_no = v_mobile_no  and is_active =1) then

update isl.isl_web_user
set mobile_no = v_mobile_no, country_code = v_country_code
where  user_guid = v_user_guid ;

-- end if;

end if;

if (v_name is not null ) then
 
update isl.isl_web_user
set user_full_name = v_name
where  user_guid = v_user_guid ;

end if;
*/

p_user_data := v_user_data;  

else

v_user_data := '{
"status" : 4,
"message" : "Not registered user"
}';

p_user_data := v_user_data;

end if;

end;

$$;


--
