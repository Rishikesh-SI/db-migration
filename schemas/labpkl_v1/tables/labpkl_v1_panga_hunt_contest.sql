-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_panga_hunt_contest
-- Type: TABLE

-- Name: labpkl_v1_panga_hunt_contest; Type: TABLE; Schema: labpkl_v1; Owner: -
--

CREATE TABLE labpkl_v1.labpkl_v1_panga_hunt_contest (
    contest_id numeric NOT NULL,
    panga_hunt_user_id numeric,
    created_date timestamp without time zone,
    user_json jsonb
);


--
