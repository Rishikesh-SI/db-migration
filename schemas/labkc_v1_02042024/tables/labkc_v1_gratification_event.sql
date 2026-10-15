-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: labkc_v1_gratification_event
-- Type: TABLE

-- Name: labkc_v1_gratification_event; Type: TABLE; Schema: labkc_v1_02042024; Owner: -
--

CREATE TABLE labkc_v1_02042024.labkc_v1_gratification_event (
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
