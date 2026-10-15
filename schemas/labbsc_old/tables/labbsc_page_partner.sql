-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: labbsc_page_partner
-- Type: TABLE

-- Name: labbsc_page_partner; Type: TABLE; Schema: labbsc_old; Owner: -
--

CREATE TABLE labbsc_old.labbsc_page_partner (
    page_partner_id numeric NOT NULL,
    page_id numeric,
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
