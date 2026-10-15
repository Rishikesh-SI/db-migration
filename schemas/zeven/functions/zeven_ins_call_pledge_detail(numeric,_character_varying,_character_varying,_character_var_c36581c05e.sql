-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_ins_call_pledge_detail(numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_ins_call_pledge_detail(numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_ins_call_pledge_detail(p_option_type numeric, p_misscall_pledge_sid character varying, p_verified_number character varying, p_listener_node character varying, p_verification_call_time character varying, p_service_operator character varying, p_telo_circle character varying, p_number_type character varying, p_dnd_status character varying, p_ip_address character varying, p_return refcursor, p_call_pledge_detail refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
  v_sysdate timestamp(0);
	v_return numeric;
begin

  if p_option_type = 1 then
    select current_timestamp + interval '630' minute into v_sysdate;
    insert into zeven.zeven_misscall_pledge_detail(misscall_pledge_id,
                                                   misscall_pledge_sid,
                                                   verified_number,
                                                   listener_node,
                                                   verification_call_time,
                                                   service_operator,
                                                   telo_circle,
                                                   number_type,
                                                   dnd_status,
                                                   ip_address,
                                                   created_date,
                                                   updated_date,
                                                   is_active,
                                                   is_deleted
                                                  )
    values(nextval('zeven.seq_zeven_misscall_pledge_id'),
           p_misscall_pledge_sid,
           p_verified_number,
           p_listener_node,
           p_verification_call_time,
           p_service_operator,
           p_telo_circle,
           p_number_type,
           p_dnd_status,
           p_ip_address,
           v_sysdate,
           v_sysdate,
           1,
           0
          );
    v_return := currval('zeven.seq_zeven_misscall_pledge_id');
  else
    v_return := 0;
  end if;
  open p_call_pledge_detail for
  select misscall_pledge_id,
         misscall_pledge_sid,
         verified_number,
         listener_node,
         verification_call_time,
         service_operator,
         telo_circle,
         number_type,
         dnd_status,
         ip_address,
         created_date
  from zeven.zeven_misscall_pledge_detail;
  
  open p_return for select v_return as p_return;
exception
  when others then
    open p_return for select -1 as p_return;
end;

$$;


--
