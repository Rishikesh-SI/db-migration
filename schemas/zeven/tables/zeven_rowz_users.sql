-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_rowz_users
-- Type: TABLE

-- Name: zeven_rowz_users; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_rowz_users (
    user_id numeric NOT NULL,
    user_name character varying(100),
    twitter_handle character varying(500),
    created_date timestamp(0) without time zone,
    updated_date timestamp(0) without time zone,
    is_active numeric,
    is_deleted numeric
);


--
