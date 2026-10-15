-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_ins_newsletter_subs(character varying)
-- Type: FUNCTION

-- Name: zeven_ins_newsletter_subs(character varying); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_ins_newsletter_subs(p_emailid character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare 
  v_emailid zeven.zeven_newsletter_subscription.email_id%type = upper(p_emailid);
  v_emailexists numeric;
  v_sysdate timestamp(0) = current_timestamp at time zone 'UTC';

begin

  select 1
  into strict v_emailexists
  from zeven.zeven_newsletter_subscription
  where upper(email_id) = v_emailid;
  p_result := 0;
exception
  when no_data_found then
    insert into zeven.zeven_newsletter_subscription
    values(nextval('zeven.seq_zvn_newsletter_subscrip_id'), p_emailid, v_sysdate, v_sysdate, 1, 0);
    p_result := 1;
  when others then
    p_result := -1;
end;

$$;


--
