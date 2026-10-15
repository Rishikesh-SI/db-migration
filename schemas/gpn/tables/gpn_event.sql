-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_event
-- Type: TABLE

-- Name: gpn_event; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_event (
    event_id numeric NOT NULL,
    event_name character varying(100) NOT NULL,
    sport_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
