-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zvn_get_image_details_niu(numeric, numeric, numeric, numeric, character varying, numeric, numeric, numeric, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zvn_get_image_details_niu(numeric, numeric, numeric, numeric, character varying, numeric, numeric, numeric, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zvn_get_image_details_niu(p_userid numeric, p_venue_masterid numeric, p_is_zeven_uploads numeric, p_is_user_uploads numeric, p_review_ids character varying, p_type numeric, p_page_number numeric, p_item_count numeric, p_cur_image refcursor, p_cur_image_cnt refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
DECLARE 
V_SQL VARCHAR(2000) = ' ';
V_FROM_ROW_NUMBER	numeric = 0;
V_TO_ROW_NUMBER	numeric = 0;
V_VALID_USER numeric = 0;

BEGIN

  
  SELECT	COUNT(1)
  into    V_VALID_USER
  FROM    zeven.ZEVEN_USER    
  WHERE   user_id = P_USERID;
  
  V_FROM_ROW_NUMBER := (P_ITEM_COUNT * P_PAGE_NUMBER - (P_ITEM_COUNT-1));
  V_TO_ROW_NUMBER := (P_ITEM_COUNT * P_PAGE_NUMBER);
  
  IF P_IS_ZEVEN_UPLOADS = 1 AND P_TYPE = 1 THEN
    OPEN P_CUR_IMAGE FOR
      SELECT  PHOTO_ID,IMAGE_NAME,PLAY_ACTIVITY_TYPE_ID,PLAY_ACTIVITY_REF_ID,FACILITY_ID,USER_ID,
              IS_SAVED,IS_DELETED,IS_ZEVEN_PUBLISHED,IS_PUBLISHED,IMG_EXTENSION,IMG_COURTESY
      FROM    (
               SELECT   ROW_NUMBER () OVER ( ORDER BY CREATED_DATE DESC) AS ORDER_NO,
                        PHOTO_ID,IMAGE_NAME,PLAY_ACTIVITY_TYPE_ID,PLAY_ACTIVITY_REF_ID,FACILITY_ID,USER_ID,
                        IS_SAVED,IS_DELETED,IS_ZEVEN_PUBLISHED,IS_PUBLISHED,CREATED_DATE,UPDATED_DATE ,IMG_EXTENSION,IMG_COURTESY
                FROM    zeven.ZEVEN_PIC_PLAY_USR_ACT_MAP
                WHERE   IS_ZEVEN_PUBLISHED = 1
                        AND
                        IS_PUBLISHED IN (1,3)
                        AND
                        FACILITY_ID = P_VENUE_MASTERID
                        AND
                        IS_SAVED = 1
                        AND
                        IS_DELETED = 0
              )a
      WHERE ORDER_NO BETWEEN V_FROM_ROW_NUMBER AND V_TO_ROW_NUMBER 
      ORDER BY CREATED_DATE DESC;
      
      OPEN P_CUR_IMAGE_CNT FOR
        SELECT   COUNT(1) AS CNT
        FROM    zeven.ZEVEN_PIC_PLAY_USR_ACT_MAP
        WHERE   IS_ZEVEN_PUBLISHED = 1
                AND
                IS_PUBLISHED IN (1,3)
                AND
                FACILITY_ID = P_VENUE_MASTERID
                AND
                IS_SAVED = 1
                AND
                IS_DELETED = 0;
  END IF;
  
  IF P_IS_USER_UPLOADS = 1 AND P_TYPE = 2 THEN
    OPEN P_CUR_IMAGE FOR
      SELECT  PHOTO_ID,IMAGE_NAME,PLAY_ACTIVITY_TYPE_ID,PLAY_ACTIVITY_REF_ID,FACILITY_ID,USER_ID,
              IS_SAVED,IS_DELETED,IS_ZEVEN_PUBLISHED,IS_PUBLISHED,IMG_EXTENSION,IMG_COURTESY
      FROM    (
               SELECT   ROW_NUMBER () OVER ( ORDER BY CREATED_DATE DESC) AS ORDER_NO,
                        PHOTO_ID,IMAGE_NAME,PLAY_ACTIVITY_TYPE_ID,PLAY_ACTIVITY_REF_ID,FACILITY_ID,USER_ID,
                        IS_SAVED,IS_DELETED,IS_ZEVEN_PUBLISHED,IS_PUBLISHED,CREATED_DATE,UPDATED_DATE ,IMG_EXTENSION,IMG_COURTESY
                FROM    zeven.ZEVEN_PIC_PLAY_USR_ACT_MAP
                WHERE   IS_PUBLISHED IN (1,3)
                        AND
                        COALESCE(USER_ID,0) > 0 
                        AND
                        FACILITY_ID = P_VENUE_MASTERID
                        AND
                        IS_SAVED = 1
                        AND
                        IS_DELETED = 0
              )a
      WHERE ORDER_NO BETWEEN V_FROM_ROW_NUMBER AND V_TO_ROW_NUMBER 
      ORDER BY CREATED_DATE DESC;
      
       OPEN P_CUR_IMAGE_CNT FOR
        SELECT  COUNT(1) AS CNT
        FROM    zeven.ZEVEN_PIC_PLAY_USR_ACT_MAP
        WHERE   IS_PUBLISHED IN (1,3)
                AND
                COALESCE(USER_ID,0) > 0 
                AND
                FACILITY_ID = P_VENUE_MASTERID
                AND
                IS_SAVED = 1
                AND
                IS_DELETED = 0;
  END IF;
  
  IF P_USERID IS NOT NULL AND P_TYPE = 3 AND V_VALID_USER = 1 THEN
    OPEN P_CUR_IMAGE FOR
      SELECT  PHOTO_ID,IMAGE_NAME,PLAY_ACTIVITY_TYPE_ID,PLAY_ACTIVITY_REF_ID,FACILITY_ID,USER_ID,
              IS_SAVED,IS_DELETED,IS_ZEVEN_PUBLISHED,IS_PUBLISHED,IMG_EXTENSION,IMG_COURTESY
      FROM    (
               SELECT   ROW_NUMBER () OVER ( ORDER BY CREATED_DATE DESC) AS ORDER_NO,
                        PHOTO_ID,IMAGE_NAME,PLAY_ACTIVITY_TYPE_ID,PLAY_ACTIVITY_REF_ID,FACILITY_ID,USER_ID,
                        IS_SAVED,IS_DELETED,IS_ZEVEN_PUBLISHED,IS_PUBLISHED ,CREATED_DATE,UPDATED_DATE,IMG_EXTENSION,IMG_COURTESY
                FROM    zeven.ZEVEN_PIC_PLAY_USR_ACT_MAP
                WHERE   IS_PUBLISHED IN (1,3)
                        AND
                        USER_ID = P_USERID
                        AND
                        IS_SAVED = 1
                        AND
                        IS_DELETED = 0
                )a
      WHERE ORDER_NO BETWEEN V_FROM_ROW_NUMBER AND V_TO_ROW_NUMBER 
      ORDER BY CREATED_DATE DESC;
      
      OPEN P_CUR_IMAGE_CNT FOR
        SELECT  COUNT(1) AS CNT
        FROM    zeven.ZEVEN_PIC_PLAY_USR_ACT_MAP
                WHERE   IS_PUBLISHED IN (1,3)
                        AND
                        USER_ID = P_USERID
                        AND
                        IS_SAVED = 1
                        AND
                        IS_DELETED = 0;
  END IF;
  
  IF P_REVIEW_IDS IS NOT NULL AND P_TYPE  = 4 THEN
    /*V_SQL := '
             SELECT   PHOTO_ID,IMAGE_NAME,PLAY_ACTIVITY_TYPE_ID,PLAY_ACTIVITY_REF_ID,FACILITY_ID,USER_ID,
                      IS_SAVED,IS_DELETED,IS_ZEVEN_PUBLISHED,IS_PUBLISHED ,CREATED_DATE,UPDATED_DATE,IMG_EXTENSION,IMG_COURTESY
              FROM    zeven.ZEVEN_PIC_PLAY_USR_ACT_MAP
              WHERE   IS_PUBLISHED IN (1,3)
                      AND
                      PLAY_ACTIVITY_REF_ID IN (' || P_REVIEW_IDS || ')
                      AND
                      PLAY_ACTIVITY_TYPE_ID = 2
                      AND
                      FACILITY_ID = ' || P_VENUE_MASTERID || '
                      AND
                      IS_SAVED = 1
                      AND
                      IS_DELETED = 0
              ORDER BY CREATED_DATE DESC ';
              
    OPEN P_CUR_IMAGE FOR V_SQL;*/
    
    open p_cur_image for execute '
             SELECT   PHOTO_ID,IMAGE_NAME,PLAY_ACTIVITY_TYPE_ID,PLAY_ACTIVITY_REF_ID,FACILITY_ID,USER_ID,
                      IS_SAVED,IS_DELETED,IS_ZEVEN_PUBLISHED,IS_PUBLISHED ,CREATED_DATE,UPDATED_DATE,IMG_EXTENSION,IMG_COURTESY
              FROM    zeven.ZEVEN_PIC_PLAY_USR_ACT_MAP
              WHERE   IS_PUBLISHED IN (1,3)
                      AND
                      PLAY_ACTIVITY_REF_ID IN (' || P_REVIEW_IDS || ')
                      AND
                      PLAY_ACTIVITY_TYPE_ID = 2
                      AND
                      FACILITY_ID = ' || P_VENUE_MASTERID || '
                      AND
                      IS_SAVED = 1
                      AND
                      IS_DELETED = 0
              ORDER BY CREATED_DATE DESC ';
    
    OPEN P_CUR_IMAGE_CNT FOR
        execute ' SELECT  COUNT(1) AS CNT
          FROM    zeven.ZEVEN_PIC_PLAY_USR_ACT_MAP
          WHERE   IS_PUBLISHED IN (1,3)
                  AND
                  PLAY_ACTIVITY_REF_ID IN (' || P_REVIEW_IDS || ')
                  AND
                  PLAY_ACTIVITY_TYPE_ID = 2
                  AND
                  FACILITY_ID = ' || P_VENUE_MASTERID || '
                  AND
                  IS_SAVED = 1
                  AND
                  IS_DELETED = 0';
  END IF;
  
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
