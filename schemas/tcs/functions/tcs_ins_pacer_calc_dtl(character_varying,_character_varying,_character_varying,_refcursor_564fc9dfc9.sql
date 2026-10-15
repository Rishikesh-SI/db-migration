-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_ins_pacer_calc_dtl(character varying, character varying, character varying, refcursor, refcursor)
-- Type: FUNCTION

-- Name: tcs_ins_pacer_calc_dtl(character varying, character varying, character varying, refcursor, refcursor); Type: FUNCTION; Schema: tcs; Owner: -
--

CREATE FUNCTION tcs.tcs_ins_pacer_calc_dtl(p_pacer_calc_type character varying, p_pacer_name character varying, p_pacer_emailid character varying, p_return refcursor, p_pacer_calc_dtl refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare 
  v_calctype_email_count numeric;
  v_return numeric;
begin

  select count(*)
  into v_calctype_email_count
  from tcs.tcs_pacer_calculator_detail
  where pacer_calculator_type = p_pacer_calc_type
  and pacer_email_id = p_pacer_emailid;
  
  if v_calctype_email_count = 0 then
    insert into tcs.tcs_pacer_calculator_detail(tcs_pacer_calc_dtl_id,
                                                   pacer_calculator_type,
                                                   pacer_name,
                                                   pacer_email_id,
                                                   created_date,
                                                   updated_date,
                                                   is_active,
                                                   is_deleted
                                                  )
    values(nextval('tcs.seq_tcs_pacer_calc_dtl_id'),
           p_pacer_calc_type,
           p_pacer_name,
           p_pacer_emailid,
           current_timestamp,
           current_timestamp,
           1,
           0
          );
    v_return := 1;
  else
    v_return := 0;
  end if;
  open p_return for
  select v_return;
  open p_pacer_calc_dtl for
  select *
  from tcs.tcs_pacer_calculator_detail;
exception
  when others then
    v_return := -1;
    open p_return for
  select v_return;
  open p_pacer_calc_dtl for
  select *
  from tcs.tcs_pacer_calculator_detail where 1=2;
end;

$$;


--
