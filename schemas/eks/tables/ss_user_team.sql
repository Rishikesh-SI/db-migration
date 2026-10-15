-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_user_team
-- Type: TABLE

-- Name: ss_user_team; Type: TABLE; Schema: eks; Owner: -
--

CREATE TABLE eks.ss_user_team (
    cf_userid numeric(38,0) NOT NULL,
    cf_playerid numeric(25,0) NOT NULL,
    cf_tourid numeric(20,0) NOT NULL,
    cf_skillid numeric(10,0) NOT NULL,
    cf_player_categoryid numeric(10,0) NOT NULL,
    cf_source_typeid numeric(10,0) NOT NULL,
    favt_team_id numeric(20,0) NOT NULL,
    is_active numeric(1,0) NOT NULL,
    is_deleted numeric(1,0) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL
);


--
