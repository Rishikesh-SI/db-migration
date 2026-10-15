-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_google_form_det(integer, refcursor)
-- Type: FUNCTION

-- Name: zeven_get_google_form_det(integer, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_google_form_det(p_user_id integer, p_result refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
begin

open p_result for select  USER_ID,
                              GOOGLE_FORM_DATE,
                              GOALCOUNT,
                              NUMBER_OF_REFERRAL_SALES,
                              NUMBER_OF_EARNINGS,
                              REFERENCE_CODE from zeven.ZEVEN_GOOGLE_FORM_DET
where user_id=p_user_id;


end;
$$;


--
