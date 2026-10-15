-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_featured_venue(numeric, numeric, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_featured_venue(numeric, numeric, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_featured_venue(p_page_number numeric, p_items_number numeric, p_cur_venue_count refcursor, is_featured_venue_cursor refcursor, p_cur_venue_event refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
declare 
V_FROM_ROW_NUMBER	numeric := 0;
V_TO_ROW_NUMBER	numeric := 0;

BEGIN

  V_FROM_ROW_NUMBER := (P_ITEMS_NUMBER * P_PAGE_NUMBER - (P_ITEMS_NUMBER-1));
  V_TO_ROW_NUMBER := (P_ITEMS_NUMBER * P_PAGE_NUMBER);


OPEN P_CUR_VENUE_COUNT FOR 
SELECT   COUNT(1) AS COUNTS 
    FROM
        ( SELECT     ROW_NUMBER () OVER ( ORDER BY CREATED_DATE DESC ) ORDER_NO           
              FROM   zeven.ZEVEN_VENUE_MASTER
              WHERE  IS_FEATURED  = 1
                AND  IS_ACTIVE    = 1
         )A
    WHERE  ORDER_NO BETWEEN  V_FROM_ROW_NUMBER AND V_TO_ROW_NUMBER;

OPEN IS_FEATURED_VENUE_CURSOR FOR
SELECT  * 
    FROM
        ( SELECT        VM.VENUE_MASTERID,
                        VENUE_NAME,
                        SPORT_MASTER_ID,
                        SHORTNAME,
                        DISPLAY_NAME,
                        KNOWN_AS,
                        EMAIL_ID,
                        PINCODE,
                        LATITUDE,
                        LONGITUDE,
                        DESCRIPTION,
                        MOBILE_NO,
                        MOBILE_NO1,
                        TELEPHONE_NO,
                        ADDRESS,
                        ROW_NUMBER () OVER ( ORDER BY CREATED_DATE DESC ) ORDER_NO,
                        CREATED_DATE,
                        VENUE_TYPE,
                        coalesce(REVIEW.COUNTS,0) TOTAL_REVIEWS,
                        coalesce(RATING.COUNTS,0) TOTAL_RATINGS,
                        coalesce(FACILITY_VIEW.COUNTS,0) TOTAL_VIEWS,
                        coalesce(FACILITY_CHECKIN.COUNTS,0) TOTAL_CHECKINS,
                        null as VENUE_IMG,
                        coalesce(WANT_TO_PLAY.COUNTS,0) WANT_TO_PLAY
              FROM      zeven.ZEVEN_VENUE_MASTER VM
              LEFT JOIN  (
                            SELECT COUNT(1) AS COUNTS,VENUE_MASTERID
                            FROM zeven.ZEVEN_COMMENT_REVIEW ZCR
                            WHERE ZCR.IS_PUBLISHED <> -1
                            GROUP BY VENUE_MASTERID
                          )REVIEW
                    ON REVIEW.VENUE_MASTERID = VM.VENUE_MASTERID      
              LEFT JOIN  (
                            SELECT ROUND(AVG(RATINGS),0) AS COUNTS,VENUE_MASTERID
                            FROM zeven.ZEVEN_RATING ZR
                            GROUP BY VENUE_MASTERID
                          )RATING
                  ON RATING.VENUE_MASTERID = VM.VENUE_MASTERID
            --   LEFT JOIN  (
             --               SELECT COUNT(1) AS COUNTS,VENUE_MASTERID
            --                FROM zeven.ZEVEN_RATING ZR
            --                GROUP BY VENUE_MASTERID
             --             )RATING
              --    ON RATING.VENUE_MASTERID = VM.VENUE_MASTERID 
              LEFT JOIN (
                          select COUNT(1) as COUNTS,ARTICLEID
                          from zeven.ZEVEN_TRACK_USER_ACTIVITY ZTUA
                          where ASSET_TYPE_ID = 0 and ACTIVITYID = 13
                          group by ARTICLEID 
                        )FACILITY_VIEW
                  on FACILITY_VIEW.ARTICLEID = VM.VENUE_MASTERID
              left join (
                          select COUNT(1) as COUNTS,VENUE_MASTERID
                          from zeven.ZEVEN_VENUE_CHECKINS
                          group by VENUE_MASTERID
                        )FACILITY_CHECKIN
                  ON FACILITY_CHECKIN.VENUE_MASTERID = VM.VENUE_MASTERID
             left join (                                    
                          select count(1) AS COUNTS, VENUE_MASTERID 
                          from ZEVEN.ZEVEN_WANT_TO_PLAY
                          group by VENUE_MASTERID
                        )WANT_TO_PLAY
                ON   WANT_TO_PLAY.VENUE_MASTERID = VM.VENUE_MASTERID    
              WHERE     IS_FEATURED= 1
                AND     IS_ACTIVE    = 1
         )B
    WHERE  ORDER_NO BETWEEN  V_FROM_ROW_NUMBER AND V_TO_ROW_NUMBER
    ORDER BY CREATED_DATE DESC;
  
OPEN  P_CUR_VENUE_EVENT FOR
      SELECT  E.ZEVEN_EVENTID,E.EVENT_NAME,E.EVENT_DATE,E.REGISTRATION_FEE,E.WINNING_PRIZE,E.EVENT_TYPE,E.VENUE_MASTERID
      FROM    zeven.ZEVEN_EVENT E
      INNER JOIN  zeven.ZEVEN_VENUE_MASTER ZVM
            ON  ZVM.VENUE_MASTERID = E.VENUE_MASTERID
      WHERE             IS_FEATURED= 1
                AND     IS_ACTIVE    = 1
                AND     IS_PUBLISHED = 1
                AND     IS_DELETED   = 0;  
  

END;
$$;


--
