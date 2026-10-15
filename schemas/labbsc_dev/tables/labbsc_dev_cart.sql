-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_cart
-- Type: TABLE

-- Name: labbsc_dev_cart; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_cart (
    cart_id numeric NOT NULL,
    user_id numeric,
    activity_id numeric,
    gross_amount numeric,
    is_discounted numeric,
    discount_code character varying(50),
    discount_amount numeric,
    net_amount numeric,
    status numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    pancard_number text,
    gst_number text,
    is_state numeric,
    counseller_id numeric,
    counseller_name character varying(500),
    session_id numeric,
    request_id numeric,
    video_id numeric,
    emi_json jsonb,
    reference_type character varying(500),
    upload_flag numeric
);


--
