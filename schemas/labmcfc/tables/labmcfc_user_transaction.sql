-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: labmcfc_user_transaction
-- Type: TABLE

-- Name: labmcfc_user_transaction; Type: TABLE; Schema: labmcfc; Owner: -
--

CREATE TABLE labmcfc.labmcfc_user_transaction (
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
