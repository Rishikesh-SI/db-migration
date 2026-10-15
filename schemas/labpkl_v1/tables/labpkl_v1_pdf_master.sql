-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_pdf_master
-- Type: TABLE

-- Name: labpkl_v1_pdf_master; Type: TABLE; Schema: labpkl_v1; Owner: -
--

CREATE TABLE labpkl_v1.labpkl_v1_pdf_master (
    pdf_master_id numeric NOT NULL,
    pdf_name character varying(100) NOT NULL,
    pdf_display_name character varying(256) NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric
);


--
