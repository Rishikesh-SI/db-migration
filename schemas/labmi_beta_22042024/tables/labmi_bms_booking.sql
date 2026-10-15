-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_bms_booking
-- Type: TABLE

-- Name: labmi_bms_booking; Type: TABLE; Schema: labmi_beta_22042024; Owner: -
--

CREATE TABLE labmi_beta_22042024.labmi_bms_booking (
    bkg_id character varying NOT NULL,
    app_name character varying,
    venue_name character varying,
    event_title character varying,
    trans_date timestamp without time zone,
    show_date timestamp without time zone,
    ticket_qty numeric,
    ticket_amt numeric,
    ticket_price numeric,
    category character varying,
    payment_mode character varying,
    customer_mail_id character varying,
    customer_mobile_number character varying,
    status character varying,
    add_info jsonb,
    created_date timestamp without time zone,
    is_used numeric
);


--
