-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_trend_master
-- Type: TABLE

-- Name: zeven_trend_master; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_trend_master (
    zeven_trend_masterid numeric NOT NULL,
    articleid numeric,
    sportid numeric,
    categoryid numeric,
    asset_type_id numeric,
    created_date timestamp(0) without time zone DEFAULT now(),
    updated_date timestamp(0) without time zone DEFAULT now(),
    trend_type_id numeric,
    is_latest numeric
);


--
