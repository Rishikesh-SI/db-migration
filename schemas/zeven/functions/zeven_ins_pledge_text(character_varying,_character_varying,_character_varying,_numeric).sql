-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_ins_pledge_text(character varying, character varying, character varying, numeric)
-- Type: FUNCTION

-- Name: zeven_ins_pledge_text(character varying, character varying, character varying, numeric); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_ins_pledge_text(p_pledge_text character varying, p_ip_address character varying, p_mobileno character varying, p_referenceno numeric, OUT p_return numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
  p_sysdate timestamp(0);
  p_mobile_check numeric;

begin

  select current_timestamp+interval '630' minute into p_sysdate from dual;
  select count(*)
  into p_mobile_check
  from zeven.zeven_pledge_text
  where mobile_no = p_mobileno;
  if p_mobile_check = 0 then
    insert into zeven.zeven_pledge_text(pledge_text_id,
                                        pledge_text,
                                        ip_address,
                                        created_date,
                                        updated_date,
                                        is_active,
                                        is_deleted,
                                        mobile_no,
                                        reference_no
                                       )
    values(nextval('zeven.seq_zeven_pledge_text_id'),
           p_pledge_text,
           p_ip_address,
           p_sysdate,
           p_sysdate,
           1,
           0,
           p_mobileno,
           p_referenceno
          );
    p_return := 1;
  else
    p_return := 0;
  end if;
exception
  when others then
    p_return := -1;
end;

$$;


--
