-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_payment_validation_log
-- Type: TABLE

-- Name: labuww_payment_validation_log; Type: TABLE; Schema: labuww; Owner: -
--

CREATE TABLE labuww.labuww_payment_validation_log (
    log_id bigint NOT NULL,
    user_name character varying(255),
    user_email character varying(255),
    user_country character varying(100),
    platform character varying(50),
    app_version character varying(50),
    item_id character varying(100),
    item_type character varying(50),
    access_fee_id character varying(100),
    payment_receipt text,
    purchase_datetime timestamp without time zone,
    store_validation_status character varying(50),
    inplayer_validation_status character varying(50),
    raw_payload jsonb,
    created_at timestamp without time zone DEFAULT now()
);


--
