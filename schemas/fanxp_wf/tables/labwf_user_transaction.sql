-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_user_transaction
-- Type: TABLE

-- Name: labwf_user_transaction; Type: TABLE; Schema: fanxp_wf; Owner: -
--

CREATE TABLE fanxp_wf.labwf_user_transaction (
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
