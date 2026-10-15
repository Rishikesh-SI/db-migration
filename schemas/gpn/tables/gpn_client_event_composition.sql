-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_client_event_composition
-- Type: TABLE

-- Name: gpn_client_event_composition; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_client_event_composition (
    client_event_composition_id numeric NOT NULL,
    client_id numeric NOT NULL,
    event_id numeric NOT NULL,
    child_event_id numeric NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric,
    for_editorial numeric,
    content_type character varying(512)
);


--
