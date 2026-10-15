-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_event
-- Type: TABLE

-- Name: gpn_event; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_event (
    event_id numeric NOT NULL,
    event_name character varying(100) NOT NULL,
    for_admin_notification numeric DEFAULT 0 NOT NULL,
    content_type character varying(100),
    sport_id numeric
);


--
