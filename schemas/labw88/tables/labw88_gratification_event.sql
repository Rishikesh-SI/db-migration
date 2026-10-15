-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: labw88_gratification_event
-- Type: TABLE

-- Name: labw88_gratification_event; Type: TABLE; Schema: labw88; Owner: -
--

CREATE TABLE labw88.labw88_gratification_event (
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
