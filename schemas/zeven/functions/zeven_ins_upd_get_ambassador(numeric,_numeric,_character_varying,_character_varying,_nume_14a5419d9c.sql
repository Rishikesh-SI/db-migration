-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_ins_upd_get_ambassador(numeric, numeric, character varying, character varying, numeric, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_ins_upd_get_ambassador(numeric, numeric, character varying, character varying, numeric, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_ins_upd_get_ambassador(p_option_id numeric, p_ambassador_id numeric, p_ambassador_name character varying, p_image character varying, p_is_shown numeric, p_result refcursor, p_data refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

  declare
    
    v_ambassador_id zeven.zeven_rowz_ambassador.ambassador_id%type = p_ambassador_id;
    v_sysdate timestamp(0) = current_timestamp;
	v_result numeric;
    
  begin

    
    if p_option_id = 1 then
      
      v_ambassador_id := nextval('zeven.seq_zeven_zeven_ambassador_id');
      
      insert into zeven.zeven_rowz_ambassador(ambassador_id,
                                              ambassador_name,
                                              image,
                                              is_shown,
                                              created_date,
                                              updated_date,
                                              is_active,
                                              is_deleted)
      values(v_ambassador_id,
             p_ambassador_name,
             p_image,
             p_is_shown,
             v_sysdate,
             v_sysdate,
             1,
             0);
        
    else
      
      update zeven.zeven_rowz_ambassador
      set    image         = p_image,
             is_shown      = p_is_shown,
             updated_date  = v_sysdate
      where  ambassador_id = p_ambassador_id;
      
    end if;
    
    open p_data for
      
      select *
      from   zeven.zeven_rowz_ambassador
      where  ambassador_id = case p_option_id  when 1 then  v_ambassador_id  when 2 then  p_ambassador_id  else ambassador_id end;
	
	open p_result for select 1 as p_result;
    
  end;

$$;


--
