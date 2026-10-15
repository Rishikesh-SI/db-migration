-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_ins_upd_ad_management(numeric, text, text, numeric)
-- Type: FUNCTION

-- Name: upp_ins_upd_ad_management(numeric, text, text, numeric); Type: FUNCTION; Schema: upp; Owner: -
--

CREATE FUNCTION upp.upp_ins_upd_ad_management(p_id numeric, p_type text, p_ad_code text, p_active numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
     v_id numeric;
     
begin
	
     if exists (select ad_id from  upp.upp_ad_management where id=p_id ) then
     	update upp.upp_ad_management set 
          ad_type= p_type,
          ad_code=p_ad_code,
          active=p_active
          where id=p_id;
  	else
     	v_id := nextval('upp.seq_upp_ad_id');
     	insert into upp.upp_ad_management
          values(v_id,p_type,p_ad_code,p_active);
	end if;
	
     p_result := 1;

 exception
 	when others then
 		p_result := -1;

end;

 $$;


--
