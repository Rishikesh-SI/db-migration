-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_site_partner
-- Type: TABLE

-- Name: yho_site_partner; Type: TABLE; Schema: yho; Owner: -
--

CREATE TABLE yho.yho_site_partner (
    site_partner_id numeric NOT NULL,
    site_id numeric NOT NULL,
    partner_id numeric NOT NULL,
    handle character varying(50),
    profile_url character varying(3000),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL
);


--
