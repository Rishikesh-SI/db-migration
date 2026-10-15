-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_showcase_slide
-- Type: TABLE

-- Name: zeven_showcase_slide; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_showcase_slide (
    showcase_slide_id numeric NOT NULL,
    title character varying(500),
    image_url character varying(1000),
    slugtitle character varying(500),
    slug_url character varying(1000),
    text character varying(2500),
    link character varying(1000),
    related_title character varying(500),
    related_slug character varying(500),
    related_link character varying(500),
    ribbons character varying(500),
    ribbons_align character varying(500),
    order_ numeric,
    is_active numeric,
    is_delete numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    catid numeric,
    showcase_type character varying(1000),
    related_type character varying(4000),
    showcase_main_type character varying(500),
    on_frontend numeric,
    image_url_retina character varying(1000),
    image_url_mobile character varying(1000),
    link_target character varying(100),
    si_client_id numeric
);


--
