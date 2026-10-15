-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_site_partner
-- Type: TABLE

-- Name: labisl_v1_site_partner; Type: TABLE; Schema: labisl_v1; Owner: -
--

CREATE TABLE labisl_v1.labisl_v1_site_partner (
    site_partner_id numeric NOT NULL,
    site_id numeric,
    partner_id numeric,
    handle character varying(50),
    profile_url character varying(3000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric
);


--
