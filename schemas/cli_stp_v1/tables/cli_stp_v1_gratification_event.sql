-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cli_stp_v1
-- Object: cli_stp_v1_gratification_event
-- Type: TABLE

-- Name: cli_stp_v1_gratification_event; Type: TABLE; Schema: cli_stp_v1; Owner: -
--

CREATE TABLE cli_stp_v1.cli_stp_v1_gratification_event (
    event_id numeric NOT NULL,
    event_name character varying(500),
    gratification_value numeric,
    is_active numeric,
    is_deleted numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    better_luck_value numeric
);


--
