-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: labgfg_gratification_event
-- Type: TABLE

-- Name: labgfg_gratification_event; Type: TABLE; Schema: labgfg; Owner: -
--

CREATE TABLE labgfg.labgfg_gratification_event (
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
