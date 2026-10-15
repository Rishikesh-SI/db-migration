-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_branded_survey_response
-- Type: TABLE

-- Name: labrr_branded_survey_response; Type: TABLE; Schema: labrr; Owner: -
--

CREATE TABLE labrr.labrr_branded_survey_response (
    id bigint NOT NULL,
    user_guid character varying(100) NOT NULL,
    survey_id character varying(100) NOT NULL,
    activity_id character varying(150),
    answers jsonb,
    is_reward_sent boolean DEFAULT false NOT NULL,
    created_date timestamp without time zone DEFAULT (now() AT TIME ZONE 'UTC'::text) NOT NULL
);


--
