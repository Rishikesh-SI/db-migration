-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_save_user_mentor_mapping(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labbsc_dev_save_user_mentor_mapping(numeric, numeric, numeric); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_save_user_mentor_mapping(p_user_id numeric, p_mentor_id numeric, p_cart_id numeric, OUT p_ret_type numeric, OUT p_user_mentor_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
v_mentor_name varchar(4000);
v_role text;
v_merchant_name text;
begin 

if not exists(select 1 from labbsc_dev.labbsc_dev_user_mentor_mapping
			 where cart_id=p_cart_id
			  and user_id=p_user_id ) then
insert into  labbsc_dev.labbsc_dev_user_mentor_mapping
select  nextval('labbsc_dev.seq_labbsc_dev_user_mentor_id'),
p_user_id  ,
p_mentor_id  ,
p_cart_id ; 
else
update labbsc_dev.labbsc_dev_user_mentor_mapping
set mentor_id=p_mentor_id,
 cart_id=p_cart_id
	where user_id=p_user_id;
 
  end if;
  
  p_ret_type:=1;
  
  select u.user_name,dr.role_name from labbsc_dev.labbsc_dev_user u
  left join labbsc_dev.labbsc_dev_user_role r on u.user_id = r.user_id
  left join labbsc_dev.labbsc_dev_role dr on r.role_id = dr.role_id 
  where u.user_id = p_mentor_id
  into v_mentor_name,v_role;
  
  select da.merchant_name into v_merchant_name from labbsc_dev.labbsc_dev_user_mentor_mapping um 
 left join labbsc_dev.labbsc_dev_cart c on um.cart_id=c.cart_id
 left join labbsc_dev.labbsc_dev_journey_activity da on c.activity_id = da.activity_id 
 where c.user_id = p_user_id and c.cart_id = p_cart_id and mentor_id = p_mentor_id;
  
 select  '{"data":['||string_agg(row_to_json(row)::text,',')||']}' 
 from (
  select u.first_name,u.last_name,u.email_id,v_mentor_name as mentor_name,v_role as role,
	 v_merchant_name as merchant_name 
  from labbsc_dev.labbsc_dev_web_user u
  where user_id=p_user_id) row
  into p_user_mentor_json;
  
end;
$$;


--
