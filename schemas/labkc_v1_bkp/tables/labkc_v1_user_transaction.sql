-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_bkp
-- Object: labkc_v1_user_transaction
-- Type: TABLE

-- Name: labkc_v1_user_transaction; Type: TABLE; Schema: labkc_v1_bkp; Owner: -
--

CREATE TABLE labkc_v1_bkp.labkc_v1_user_transaction (
    user_transaction_id numeric NOT NULL,
    user_registration_id numeric,
    transaction_id character varying(256),
    acadamy_fee numeric,
    one_time_fee numeric,
    total_payment double precision,
    transaction_date timestamp without time zone,
    subscription_start_date timestamp without time zone,
    subscription_end_date timestamp without time zone,
    transaction_data jsonb,
    gst_amt double precision,
    transaction_no numeric
);


--
