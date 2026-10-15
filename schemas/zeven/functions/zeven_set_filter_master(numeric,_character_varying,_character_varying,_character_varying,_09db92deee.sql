-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_set_filter_master(numeric, character varying, character varying, character varying, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric[], numeric)
-- Type: FUNCTION

-- Name: zeven_set_filter_master(numeric, character varying, character varying, character varying, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric[], numeric); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_set_filter_master(p_zeven_filter_masterid numeric, p_filter_name character varying, p_display_name character varying, p_filter_tablename character varying, p_is_active numeric, p_is_deleted numeric, p_is_searchable numeric, p_filter_level numeric, p_parent_filter_id numeric, p_is_leaf_node numeric, p_filter_order numeric, p_is_venue_lvl_filter numeric, p_arr_sport_masterid numeric[], p_opt_type numeric, OUT p_ret_type numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

DECLARE 
V_SYSDATE                   TIMESTAMP(0) = CURRENT_TIMESTAMP at time zone 'utc';
V_ZEVEN_FILTER_MASTERID     zeven.ZEVEN_FILTER_MASTER.ZEVEN_FILTER_MASTERID%TYPE;
V_SQL_CNT                   numeric;
V_ZEVEN_FILTER_SPORT_MAP_CNT numeric = 0;

BEGIN

----------------OPT TYPE 1 FOR INSERT DATA into TABLE---------
IF  P_OPT_TYPE=1 THEN

    V_ZEVEN_FILTER_MASTERID := nextval('zeven.SEQ_ZEVEN_FILTER_MASTER_id');
    
    INSERT into zeven.ZEVEN_FILTER_MASTER
    (
      ZEVEN_FILTER_MASTERID,FILTER_NAME,DISPLAY_NAME,FILTER_TABLENAME,IS_ACTIVE,IS_DELETED,IS_SEARCHABLE,FILTER_LEVEL,PARENT_FILTER_ID,                   
      IS_LEAF_NODE,CREATED_DATE,UPDATED_DATE,FILTER_ORDER,IS_VENUE_LVL_FILTER
    )
    VALUES
    (
      V_ZEVEN_FILTER_MASTERID,P_FILTER_NAME,P_DISPLAY_NAME,P_FILTER_TABLENAME,P_IS_ACTIVE,P_IS_DELETED,P_IS_SEARCHABLE,P_FILTER_LEVEL,
      P_PARENT_FILTER_ID,P_IS_LEAF_NODE,V_SYSDATE,V_SYSDATE,P_FILTER_ORDER,P_IS_VENUE_LVL_FILTER
    );
    
    FOR I IN 1..array_length(P_ARR_SPORT_MASTERID,1) LOOP 
      IF COALESCE(P_ARR_SPORT_MASTERID[I],0) > 0 THEN
        INSERT into zeven.ZEVEN_FILTER_SPORT_MAP
        (
          ZEVEN_FILTER_SPORT_MAPID,FILTER_MASTERID,SPORT_MASTERID,CREATED_DATE,UPDATED_DATE                   
        )
        VALUES
        (
          nextval('zeven.SEQ_ZEVEN_FILTER_SPORT_MAPID'),V_ZEVEN_FILTER_MASTERID,P_ARR_SPORT_MASTERID[I],V_SYSDATE,V_SYSDATE
        );
      END IF;
    END LOOP;
      
END IF;
----------------OPT TYPE 2 FOR UPDATE TABLE---------
IF P_OPT_TYPE=2 THEN

  UPDATE zeven.ZEVEN_FILTER_MASTER
  SET  
  FILTER_NAME        =COALESCE(P_FILTER_NAME,FILTER_NAME),   
  DISPLAY_NAME       =COALESCE(P_DISPLAY_NAME,DISPLAY_NAME),
  FILTER_TABLENAME   =COALESCE(P_FILTER_TABLENAME,FILTER_TABLENAME),    
  IS_ACTIVE          =COALESCE(P_IS_ACTIVE,IS_ACTIVE),      
  IS_DELETED         =COALESCE(P_IS_DELETED,IS_DELETED),      
  IS_SEARCHABLE      =COALESCE(P_IS_SEARCHABLE,IS_SEARCHABLE),     
  FILTER_LEVEL       =COALESCE(P_FILTER_LEVEL,FILTER_LEVEL),
  PARENT_FILTER_ID   =COALESCE(P_PARENT_FILTER_ID,PARENT_FILTER_ID),     
  IS_LEAF_NODE       =COALESCE(P_IS_LEAF_NODE,IS_LEAF_NODE),   
  UPDATED_DATE       =V_SYSDATE ,              
  FILTER_ORDER       =COALESCE(P_FILTER_ORDER,FILTER_ORDER),
  IS_VENUE_LVL_FILTER = COALESCE(P_IS_VENUE_LVL_FILTER,IS_VENUE_LVL_FILTER)
  WHERE ZEVEN_FILTER_MASTERID=P_ZEVEN_FILTER_MASTERID;
  
  SELECT  COUNT(1)
  into    V_ZEVEN_FILTER_SPORT_MAP_CNT
  FROM    zeven.ZEVEN_FILTER_SPORT_MAP 
  WHERE   FILTER_MASTERID = P_ZEVEN_FILTER_MASTERID;
  
  IF V_ZEVEN_FILTER_SPORT_MAP_CNT > 0 THEN
    DELETE FROM zeven.ZEVEN_FILTER_SPORT_MAP WHERE FILTER_MASTERID=P_ZEVEN_FILTER_MASTERID;
    /* COMMIT; */
  END IF;
  
  FOR I IN 1..array_length(P_ARR_SPORT_MASTERID,1) LOOP 
      IF COALESCE(P_ARR_SPORT_MASTERID[I],0) > 0 THEN
        INSERT into zeven.ZEVEN_FILTER_SPORT_MAP
        (
          ZEVEN_FILTER_SPORT_MAPID,FILTER_MASTERID,SPORT_MASTERID,CREATED_DATE,UPDATED_DATE                   
        )
        VALUES
        (
          nextval('zeven.SEQ_ZEVEN_FILTER_SPORT_MAPID'),V_ZEVEN_FILTER_MASTERID,P_ARR_SPORT_MASTERID[I],V_SYSDATE,V_SYSDATE
        );
      END IF;
    END LOOP;
END IF;

----------------OPT TYPE 3 FOR UPDATE TABLE---------
IF P_OPT_TYPE=3 THEN
 
 DELETE FROM zeven.ZEVEN_FILTER_MASTER
 WHERE ZEVEN_FILTER_MASTERID=P_ZEVEN_FILTER_MASTERID;
END IF;
/* COMMIT; */
P_RET_TYPE := 1;
EXCEPTION 
WHEN OTHERS THEN 
/* ROLLBACK; */
P_RET_TYPE := -1111;

END;

$$;


--
