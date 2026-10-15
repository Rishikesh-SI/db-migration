-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_city_activity_report_25082021
-- Type: TABLE

-- Name: labmao_city_activity_report_25082021; Type: TABLE; Schema: labmao; Owner: -
--

CREATE TABLE labmao.labmao_city_activity_report_25082021 (
    activity_report_id numeric,
    city character varying(500),
    distance numeric(10,4),
    curr_rank numeric,
    prev_rank numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    total_participation numeric,
    state_name character varying(500),
    pledged_distance numeric(10,4),
    type text
);


--
