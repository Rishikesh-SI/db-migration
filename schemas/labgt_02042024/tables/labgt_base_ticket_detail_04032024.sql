-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_base_ticket_detail_04032024
-- Type: TABLE

-- Name: labgt_base_ticket_detail_04032024; Type: TABLE; Schema: labgt_02042024; Owner: -
--

CREATE TABLE labgt_02042024.labgt_base_ticket_detail_04032024 (
    ticket_id character varying,
    ticket_name character varying,
    ticket_bought character varying,
    ticket_status character varying,
    ticket_bought_id character varying,
    is_ticket_printed text,
    show_start_datetime timestamp without time zone,
    show_end_datetime timestamp without time zone,
    is_ticket_redeemed text,
    ticket_item_user_params jsonb,
    ticket_inventory_user_params jsonb
);


--
