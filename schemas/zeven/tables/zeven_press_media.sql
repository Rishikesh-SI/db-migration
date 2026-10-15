-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_press_media
-- Type: TABLE

-- Name: zeven_press_media; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_press_media (
    press_media_id numeric NOT NULL,
    title character varying(400) NOT NULL,
    short_title character varying(500),
    cat_id numeric NOT NULL,
    image_link character varying(4000),
    image_zip character varying(4000),
    published numeric,
    is_deleted numeric,
    created_date timestamp(0) without time zone,
    updated_date timestamp(0) without time zone,
    created_by numeric,
    updated_by numeric,
    si_client_id numeric,
    imgzipsize character varying(10)
);


--
