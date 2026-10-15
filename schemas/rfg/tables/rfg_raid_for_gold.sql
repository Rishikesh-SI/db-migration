-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_raid_for_gold
-- Type: TABLE

-- Name: rfg_raid_for_gold; Type: TABLE; Schema: rfg; Owner: -
--

CREATE TABLE rfg.rfg_raid_for_gold (
    rfg_id numeric NOT NULL,
    first_name text,
    last_name text,
    age text,
    date_of_birth date,
    email_id text,
    mobile_number text,
    gender character varying(10),
    city text,
    institute_code text,
    standard character varying(20),
    created_date timestamp without time zone,
    guid character varying(500),
    refernce_id text,
    is_email_sent numeric,
    utm_source text,
    utm_medium text
);


--
