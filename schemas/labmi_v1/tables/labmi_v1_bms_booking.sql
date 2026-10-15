-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_bms_booking
-- Type: TABLE

-- Name: labmi_v1_bms_booking; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_bms_booking (
    bkg_id character varying,
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
