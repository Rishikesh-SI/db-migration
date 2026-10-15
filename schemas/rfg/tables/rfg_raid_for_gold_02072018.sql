-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_raid_for_gold_02072018
-- Type: TABLE

-- Name: rfg_raid_for_gold_02072018; Type: TABLE; Schema: rfg; Owner: -
--

CREATE TABLE rfg.rfg_raid_for_gold_02072018 (
    rfg_id numeric,
    first_name character varying(100),
    last_name character varying(100),
    age numeric,
    date_of_birth date,
    email_id character varying(100),
    mobile_number text,
    gender character varying(10),
    city text,
    institute_code character varying(20),
    standard character varying(20),
    created_date timestamp without time zone,
    guid character varying(500),
    refernce_id numeric
);


--
