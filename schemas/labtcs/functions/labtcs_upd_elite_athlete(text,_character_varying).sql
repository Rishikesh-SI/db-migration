-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_upd_elite_athlete(text, character varying)
-- Type: FUNCTION

-- Name: labtcs_upd_elite_athlete(text, character varying); Type: FUNCTION; Schema: labtcs; Owner: -
--

CREATE FUNCTION labtcs.labtcs_upd_elite_athlete(p_email_id text, p_elite_athlete character varying, OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare 
v_count numeric;
begin

if exists(select 1 from labtcs.labtcs_user_master
		 where email_id=p_email_id
		 and payment_status=1)
		 then
		 
		 update labtcs.labtcs_user_master
		 set elite_athlete=p_elite_athlete
		 where email_id=p_email_id
		 and payment_status=1;
		 
		 
		 p_out:=1;
		 else
		  p_out:=2;
		 
		 
		 end if;


exception when others then
 p_out:=-1;

end;
 $$;


--
