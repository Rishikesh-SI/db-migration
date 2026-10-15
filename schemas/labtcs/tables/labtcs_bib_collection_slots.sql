-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_bib_collection_slots
-- Type: TABLE

-- Name: labtcs_bib_collection_slots; Type: TABLE; Schema: labtcs; Owner: -
--

CREATE TABLE labtcs.labtcs_bib_collection_slots (
    bib_slot_id numeric NOT NULL,
    slot_date character varying,
    user_guid character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    slot_time character varying,
    slot_date_id numeric,
    category_id numeric,
    slot_day_id numeric,
    slot_time_id numeric
);


--
