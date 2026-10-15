-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: labbsc_ins_upd_job_applied(character varying, numeric[])
-- Type: FUNCTION

-- Name: labbsc_ins_upd_job_applied(character varying, numeric[]); Type: FUNCTION; Schema: labbsc_old; Owner: -
--

CREATE FUNCTION labbsc_old.labbsc_ins_upd_job_applied(p_user_guide character varying, p_job_id numeric[], OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
v_job_id numeric[];
p_user_guid varchar(1000);

begin

select job_id into v_job_id from labbsc.labbsc_web_user 
       where user_guid=p_user_guide;
v_job_id:= v_job_id || p_job_id;


/*if p_job_id in (select unnest(job_id)::numeric from labbsc.labbsc_web_user 
						where user_guid=p_user_guid
		   ) then 
		   raise notice 'v_job_id:%',v_job_id;
		   select 1/0;*/

update labbsc.labbsc_web_user
set job_id=v_job_id where user_guid=p_user_guide;
--end if;
p_result:=1;
exception
	when others then
    	p_result := -1;
end;
$$;


--
