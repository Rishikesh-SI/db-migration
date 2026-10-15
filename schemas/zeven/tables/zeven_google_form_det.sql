-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_google_form_det
-- Type: TABLE

-- Name: zeven_google_form_det; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_google_form_det (
    zvn_google_form_det_id numeric NOT NULL,
    user_id numeric,
    google_form_date timestamp(0) without time zone,
    goalcount numeric,
    number_of_referral_sales numeric,
    number_of_earnings numeric,
    reference_code character varying(500),
    created_date timestamp(0) without time zone,
    updated_date timestamp(0) without time zone,
    is_active numeric,
    is_deleted numeric
);


--
