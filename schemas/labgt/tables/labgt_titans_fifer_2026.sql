-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_titans_fifer_2026
-- Type: TABLE

-- Name: labgt_titans_fifer_2026; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_titans_fifer_2026 (
    id bigint NOT NULL,
    user_guid character varying,
    match_id character varying(100),
    scenario_id character varying,
    scenario_text text,
    scenario_position character varying(10),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    count integer,
    "position" character varying(10),
    module_name character varying(100)
);


--
