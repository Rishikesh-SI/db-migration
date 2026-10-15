-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_pdf_master
-- Type: TABLE

-- Name: zeven_pdf_master; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_pdf_master (
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
