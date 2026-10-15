-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_gratification_event
-- Type: TABLE

-- Name: labfih_gratification_event; Type: TABLE; Schema: labfih; Owner: -
--

CREATE TABLE labfih.labfih_gratification_event (
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
