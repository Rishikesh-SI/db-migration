-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_team_user_map
-- Type: TABLE

-- Name: stn_team_user_map; Type: TABLE; Schema: stn; Owner: -
--

CREATE TABLE stn.stn_team_user_map (
    team_user_map_id numeric NOT NULL,
    team_id numeric NOT NULL,
    user_id numeric NOT NULL,
    player_no numeric,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    tum_guid character varying(256) NOT NULL
);


--
