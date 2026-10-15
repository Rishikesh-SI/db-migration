-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_web_user_timeline
-- Type: TABLE

-- Name: swa_web_user_timeline; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_web_user_timeline (
    user_timeline_id numeric NOT NULL,
    web_user_id numeric,
    fev_team_id numeric,
    web_usr_team jsonb,
    created_by numeric,
    updated_by numeric,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    is_active numeric,
    web_user_guid character varying(200),
    team_id numeric
);


--
