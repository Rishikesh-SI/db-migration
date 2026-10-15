-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_volunteer_detail
-- Type: TABLE

-- Name: labpcm_volunteer_detail; Type: TABLE; Schema: labpcm; Owner: -
--

CREATE TABLE labpcm.labpcm_volunteer_detail (
    volunteer_detail_id numeric NOT NULL,
    data jsonb,
    username character varying(500),
    login_password character varying(4000),
    is_active numeric,
    is_deleted numeric,
    is_shortlisted numeric,
    is_confirmed numeric,
    volunteer_guid character varying(500),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
