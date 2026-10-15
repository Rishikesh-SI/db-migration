-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: labrg_ins_upd_ad_management(numeric, text, text, numeric)
-- Type: FUNCTION

-- Name: labrg_ins_upd_ad_management(numeric, text, text, numeric); Type: FUNCTION; Schema: labrg; Owner: -
--

CREATE FUNCTION labrg.labrg_ins_upd_ad_management(p_id numeric, p_type text, p_ad_code text, p_active numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
     v_id numeric;
     
begin
	
     if exists (select ad_id from  labrg.labrg_ad_management where id=p_id ) then
     	update labrg.labrg_ad_management set 
          ad_type= p_type,
          ad_code=p_ad_code,
          active=p_active
          where id=p_id;
  	else
     	v_id := nextval('labrg.seq_labrg_ad_id');
     	insert into labrg.labrg_ad_management
          values(v_id,p_type,p_ad_code,p_active);
	end if;
	
     p_result := 1;

 exception
 	when others then
 		p_result := -1;

end;

 $$;


--
