-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_google_form_submit(character varying)
-- Type: FUNCTION

-- Name: zeven_google_form_submit(character varying); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_google_form_submit(p_email character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare 
v_user_id varchar(20);
v_cnt numeric;
v_id numeric;
v_sysdate timestamp(0);

begin

select user_id into strict v_user_id from zeven.zeven_web_user
where upper(email_id)=upper(p_email)
and is_registered=1 and is_active=1;

select count(1) into  v_cnt from zeven.zeven_google_form
where upper(email)=upper(p_email);

if (v_cnt =0 and v_user_id is not null ) then 
select nextval('zeven.seq_zeven_google_form_id') into v_id;
  select current_timestamp into v_sysdate;
    insert into zeven.zeven_google_form(
                                  zeven_google_form_id,
                                  user_id,
                                  email,
                                  created_date,
                                  updated_date,
                                  is_active,
                                  is_deleted)
                              values
                                 (
                                 v_id,
                                 v_user_id::numeric,
                                 p_email,
                                 v_sysdate,
                                 v_sysdate,
                                 1,
                                 0
                                 );                    
             p_result :=1;
          else 
          p_result:=0;
          
          end if;
          
          exception when no_data_found then 
     p_result:=-1;

end;

$$;


--
