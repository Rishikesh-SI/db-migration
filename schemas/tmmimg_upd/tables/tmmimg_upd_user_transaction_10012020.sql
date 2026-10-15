-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_user_transaction_10012020
-- Type: TABLE

-- Name: tmmimg_upd_user_transaction_10012020; Type: TABLE; Schema: tmmimg_upd; Owner: -
--

CREATE TABLE tmmimg_upd.tmmimg_upd_user_transaction_10012020 (
    user_transaction_id numeric,
    user_id numeric,
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
    pg_transaction_id character varying(1000),
    bib_no numeric,
    mail_sent numeric
);


--
