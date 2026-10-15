-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_gratification_event
-- Type: TABLE

-- Name: labdsg_gratification_event; Type: TABLE; Schema: labdsg; Owner: -
--

CREATE TABLE labdsg.labdsg_gratification_event (
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
