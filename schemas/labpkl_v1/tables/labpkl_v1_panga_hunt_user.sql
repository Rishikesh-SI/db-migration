-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_panga_hunt_user
-- Type: TABLE

-- Name: labpkl_v1_panga_hunt_user; Type: TABLE; Schema: labpkl_v1; Owner: -
--

CREATE TABLE labpkl_v1.labpkl_v1_panga_hunt_user (
    panga_hunt_user_id numeric NOT NULL,
    email_id character varying,
    full_name character varying,
    device_token character varying,
    platform_id numeric,
    creadted_date timestamp without time zone,
    updated_date timestamp without time zone,
    user_json jsonb
);


--
