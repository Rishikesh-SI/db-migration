-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_user_tour_map
-- Type: TABLE

-- Name: ss_user_tour_map; Type: TABLE; Schema: eks; Owner: -
--

CREATE TABLE eks.ss_user_tour_map (
    cf_userid numeric(30,0) NOT NULL,
    cf_tourid numeric(20,0) NOT NULL,
    social_id character varying(4000) NOT NULL,
    cf_clientid numeric(10,0) NOT NULL,
    upper_email_id character varying(256),
    mobile_no numeric(20,0),
    fav_team_id numeric(20,0) NOT NULL,
    cf_source_typeid numeric(25,0) NOT NULL,
    is_active numeric(1,0) NOT NULL,
    is_deleted numeric(1,0) NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
