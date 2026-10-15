-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_runner_performance_history
-- Type: TABLE

-- Name: dhm_runner_performance_history; Type: TABLE; Schema: dhm; Owner: -
--

CREATE TABLE dhm.dhm_runner_performance_history (
    runner_performance_history_id numeric NOT NULL,
    first_name character varying(300) NOT NULL,
    last_name character varying,
    date_of_birth date NOT NULL,
    year numeric,
    runner_guid character varying(256) NOT NULL,
    runner_json character varying(4000) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    lastyear_race_type character varying(50),
    category_rank numeric
);


--
