-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_admin_display_flag_upd(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: ss_admin_display_flag_upd(numeric, numeric, numeric); Type: FUNCTION; Schema: eks; Owner: -
--

CREATE FUNCTION eks.ss_admin_display_flag_upd(p_opt_type numeric, p_cf_tourid numeric, p_display_flag numeric, OUT p_ret_type numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

-- ********************************PREFACE BLOCK*******************************

--  Written/Modified:      Date:           Reason:
--  GANESH M             09/01/2018      CREATION

-- ********************************END PREFACE BLOCK***************************

   

BEGIN
        
    
    IF(P_OPT_TYPE=1)  
    THEN
      
    UPDATE eks.SS_TOUR
    SET PLAYER_DISPLAY_FLAG=P_DISPLAY_FLAG
    WHERE CF_TOURID=P_CF_TOURID;
  
    P_RET_TYPE=1;
  
    END IF;
  
    IF(P_OPT_TYPE=2)  
    THEN
      
    UPDATE eks.SS_TOUR
    SET IS_ACTIVE=P_DISPLAY_FLAG
    WHERE CF_TOURID=P_CF_TOURID;
    
    P_RET_TYPE=1;
    
    END IF; 
        
 
 EXCEPTION 
 WHEN OTHERS THEN
 
 P_RET_TYPE=-1;
 END;

 

$$;


--
