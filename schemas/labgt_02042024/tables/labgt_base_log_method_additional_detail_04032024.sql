-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_base_log_method_additional_detail_04032024
-- Type: TABLE

-- Name: labgt_base_log_method_additional_detail_04032024; Type: TABLE; Schema: labgt_02042024; Owner: -
--

CREATE TABLE labgt_02042024.labgt_base_log_method_additional_detail_04032024 (
    city character varying,
    amount numeric,
    event_id character varying,
    shortcode character varying,
    buyer_name character varying,
    event_name character varying,
    event_slug character varying,
    group_name character varying,
    venue_name character varying,
    buyer_email character varying,
    buyer_phone character varying,
    organiser_id character varying,
    ticket_count numeric,
    category_name character varying,
    original_cost numeric,
    organiser_name character varying,
    ticket_details jsonb,
    transaction_id character varying,
    transaction_type character varying,
    transaction_datetime timestamp without time zone
);


--
