-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_press_media_pdf_map
-- Type: TABLE

-- Name: zeven_press_media_pdf_map; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_press_media_pdf_map (
    press_media_pdf_map_id numeric NOT NULL,
    press_media_id numeric NOT NULL,
    locale_id numeric NOT NULL,
    pdf_link character varying(4000) NOT NULL,
    published numeric,
    is_deleted numeric,
    created_date timestamp(0) without time zone,
    updated_date timestamp(0) without time zone,
    created_by numeric,
    updated_by numeric,
    si_client_id numeric,
    pdfsize character varying(10)
);


--
