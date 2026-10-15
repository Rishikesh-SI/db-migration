-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_runner_group_data
-- Type: TABLE

-- Name: upstox_runner_group_data; Type: TABLE; Schema: upstox; Owner: -
--

CREATE TABLE upstox.upstox_runner_group_data (
    runner_group_id numeric NOT NULL,
    group_name character varying(1000),
    no_of_runners numeric,
    total_distance character varying,
    no_of_runners_tier1 numeric,
    no_of_runners_tier2 numeric,
    no_of_runners_tier3 numeric,
    total_fees numeric,
    company_name character varying(1000),
    address character varying,
    contact_person character varying(1000),
    email_id character varying(1000),
    contact_number character varying(1000),
    pan_no character varying,
    gst_no character varying,
    state_code numeric,
    city_code numeric,
    group_json jsonb
);


--
