-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn_v2
-- Object: gpn_event
-- Type: TABLE

-- Name: gpn_event; Type: TABLE; Schema: gpn_v2; Owner: -
--

CREATE TABLE gpn_v2.gpn_event (
    event_id numeric,
    event_name character varying(100),
    sport_id numeric,
    client_id numeric,
    is_editorial numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric,
    content_type character varying(100)
);


--
