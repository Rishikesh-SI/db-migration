-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_bms_booking
-- Type: TABLE

-- Name: labkkr_v1_bms_booking; Type: TABLE; Schema: labkkr_v1; Owner: -
--

CREATE TABLE labkkr_v1.labkkr_v1_bms_booking (
    bkg_id numeric NOT NULL,
    app_name character varying,
    venue_name character varying,
    event_title character varying,
    trans_date timestamp without time zone,
    show_date timestamp without time zone,
    ticket_qty numeric,
    ticket_amt numeric,
    ticket_price numeric,
    tix_type character varying,
    payment_mode character varying,
    customer_mail_id character varying,
    customer_mobile_number character varying,
    status numeric
);


--
