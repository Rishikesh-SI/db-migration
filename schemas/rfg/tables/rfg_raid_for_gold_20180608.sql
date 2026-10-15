-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_raid_for_gold_20180608
-- Type: TABLE

-- Name: rfg_raid_for_gold_20180608; Type: TABLE; Schema: rfg; Owner: -
--

CREATE TABLE rfg.rfg_raid_for_gold_20180608 (
    rfg_id numeric,
    name character varying(100),
    date_of_birth date,
    email_id character varying(100),
    mobile_number text,
    gender character varying(10),
    city text,
    created_date timestamp without time zone,
    guid character varying(500)
);


--
