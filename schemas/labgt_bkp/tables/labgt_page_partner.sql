-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: labgt_page_partner
-- Type: TABLE

-- Name: labgt_page_partner; Type: TABLE; Schema: labgt_bkp; Owner: -
--

CREATE TABLE labgt_bkp.labgt_page_partner (
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
