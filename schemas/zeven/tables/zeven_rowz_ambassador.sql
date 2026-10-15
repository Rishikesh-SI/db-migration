-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_rowz_ambassador
-- Type: TABLE

-- Name: zeven_rowz_ambassador; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_rowz_ambassador (
    ambassador_id numeric NOT NULL,
    ambassador_name character varying(100),
    image character varying(500),
    is_shown numeric,
    created_date timestamp(0) without time zone,
    updated_date timestamp(0) without time zone,
    is_active numeric,
    is_deleted numeric
);


--
