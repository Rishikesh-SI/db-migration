-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: labjfc_pdf_master
-- Type: TABLE

-- Name: labjfc_pdf_master; Type: TABLE; Schema: labjfc; Owner: -
--

CREATE TABLE labjfc.labjfc_pdf_master (
    pdf_master_id numeric NOT NULL,
    pdf_name character varying(100),
    pdf_display_name character varying(256),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric
);


--
