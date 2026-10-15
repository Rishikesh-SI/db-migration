-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_admin_analytics_user_count_bak(numeric, refcursor, refcursor)
-- Type: FUNCTION

-- Name: ss_admin_analytics_user_count_bak(numeric, refcursor, refcursor); Type: FUNCTION; Schema: eks; Owner: -
--

CREATE FUNCTION eks.ss_admin_analytics_user_count_bak(p_opt_type numeric, p_cur_user_total_registration refcursor, p_cur_user_client_count refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

-- ********************************PREFACE BLOCK*******************************

--  Written/Modified:      Date:           Reason:
--  GANESH MAHANOR         16/01/2018
-- ********************************END PREFACE BLOCK***************************

	DECLARE
	      V_SYSDATE     TIMESTAMP(0);

     BEGIN

			SELECT   CAST ( (CURRENT_TIMESTAMP +CAST('330 MINUTE' AS INTERVAL) )as DATE) - INTERVAL  '1 DAY'
			INTO     V_SYSDATE;

			IF(P_OPT_TYPE=1) THEN

				OPEN P_CUR_USER_TOTAL_REGISTRATION FOR
				SELECT COUNT (*)User_Count,
				       NULL TODAY_DATE
				FROM   eks.SS_USER;

				OPEN P_CUR_USER_CLIENT_COUNT FOR
				SELECT CASE WHEN CF_CLIENTID=1 THEN 'FB'
				            WHEN CF_CLIENTID=2 THEN 'TW'
							WHEN CF_CLIENTID=3 THEN 'EMIAL'
							WHEN CF_CLIENTID=4 THEN 'MOB'
				       END CF_CLIENT,COUNT (*)User_Count ,NULL TODAY_DATE
				FROM eks.SS_USER
				GROUP BY CF_CLIENTID
				ORDER BY CF_CLIENTID;

			END IF;

			IF(P_OPT_TYPE=2) THEN

				OPEN P_CUR_USER_TOTAL_REGISTRATION FOR
				SELECT COUNT (*)User_Count,
				       CAST(DATE_TRUNC ('DAY',( CREATED_DATE +  CAST('330 MINUTE' AS INTERVAL) )  ::TIMESTAMP )AS DATE)TODAY_DATE
				FROM eks.SS_USER
				WHERE CAST(DATE_TRUNC ('DAY', ( CREATED_DATE +  CAST('330 MINUTE' AS INTERVAL) )  ::TIMESTAMP )AS DATE)=
				            V_SYSDATE
				GROUP BY CAST(DATE_TRUNC ('DAY', ( CREATED_DATE +  CAST('330 MINUTE' AS INTERVAL) )  ::TIMESTAMP )AS DATE);

				OPEN P_CUR_USER_CLIENT_COUNT FOR
				SELECT CASE WHEN CF_CLIENTID=1 THEN 'FB'
							WHEN CF_CLIENTID=2 THEN 'TW'
							WHEN CF_CLIENTID=3 THEN 'EMIAL'
							WHEN CF_CLIENTID=4 THEN 'MOB'
				       END CF_CLIENT,COUNT (*)User_Count,
				       CAST(DATE_TRUNC ('DAY',( CREATED_DATE +  CAST('330 MINUTE' AS INTERVAL) )  ::TIMESTAMP )AS DATE)TODAY_DATE
				FROM eks.SS_USER
				WHERE CAST(DATE_TRUNC ('DAY',( CREATED_DATE +  CAST('330 MINUTE' AS INTERVAL) )  ::TIMESTAMP )AS DATE)=
				V_SYSDATE
				GROUP BY CAST(DATE_TRUNC ('DAY', ( CREATED_DATE +  CAST('330 MINUTE' AS INTERVAL) )  ::TIMESTAMP )AS DATE),
				CF_CLIENTID
				ORDER BY  CF_CLIENTID;

			END IF;
END;

$$;


--
