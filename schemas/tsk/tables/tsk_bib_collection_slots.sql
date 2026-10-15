-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_bib_collection_slots
-- Type: TABLE

-- Name: tsk_bib_collection_slots; Type: TABLE; Schema: tsk; Owner: -
--

CREATE TABLE tsk.tsk_bib_collection_slots (
    bib_slot_id numeric NOT NULL,
    slot_date character varying,
    user_guid character varying,
    city_name character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    slot_time character varying,
    slot_id numeric
);


--
