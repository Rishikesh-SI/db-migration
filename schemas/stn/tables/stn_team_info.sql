-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_team_info
-- Type: TABLE

-- Name: stn_team_info; Type: TABLE; Schema: stn; Owner: -
--

CREATE TABLE stn.stn_team_info (
    team_id numeric NOT NULL,
    team_name character varying(100) NOT NULL,
    user_id numeric,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    team_guid character varying(256)
);


--
