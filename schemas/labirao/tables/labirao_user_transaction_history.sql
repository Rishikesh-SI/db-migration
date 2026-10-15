-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_user_transaction_history
-- Type: TABLE

-- Name: labirao_user_transaction_history; Type: TABLE; Schema: labirao; Owner: -
--

CREATE TABLE labirao.labirao_user_transaction_history (
    user_transaction_history_id numeric NOT NULL,
    user_id numeric NOT NULL,
    email_id character varying(1000),
    user_guid character varying(1000),
    transaction_id character varying(256),
    total_payment numeric,
    transaction_status text,
    transaction_date timestamp without time zone,
    race_category_id numeric,
    transaction_json jsonb,
    transaction_guid character varying(1000),
    payment_date timestamp without time zone,
    reason text,
    order_number character varying(1000),
    pg_transaction_id character varying(1000)
);


--
