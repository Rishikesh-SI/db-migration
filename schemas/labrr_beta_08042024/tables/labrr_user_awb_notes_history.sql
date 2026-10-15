-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_user_awb_notes_history
-- Type: TABLE

-- Name: labrr_user_awb_notes_history; Type: TABLE; Schema: labrr_beta_08042024; Owner: -
--

CREATE TABLE labrr_beta_08042024.labrr_user_awb_notes_history (
    product_cart_id numeric,
    aw_bill_number character varying(200),
    service_provider character varying(200),
    date_of_dispatch timestamp without time zone,
    courier_status character varying(200),
    received_by character varying(200),
    remarks character varying(200),
    customer_note text,
    note_status numeric,
    created_date timestamp without time zone,
    note_updated_by numeric,
    note_updated_date timestamp without time zone
);


--
