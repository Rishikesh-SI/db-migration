-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_raid_for_gold_bak
-- Type: TABLE

-- Name: rfg_raid_for_gold_bak; Type: TABLE; Schema: rfg; Owner: -
--

CREATE TABLE rfg.rfg_raid_for_gold_bak (
    rfg_id numeric NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    age numeric,
    date_of_birth date,
    email_id character varying(100),
    mobile_number text,
    gender character varying(10),
    city text,
    institute_code character varying(100),
    standard character varying(100),
    created_date timestamp without time zone,
    guid character varying(500),
    refernce_id numeric,
    is_email_sent numeric(1,0)
);


--
