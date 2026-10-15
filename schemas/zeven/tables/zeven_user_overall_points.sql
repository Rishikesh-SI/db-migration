-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_user_overall_points
-- Type: TABLE

-- Name: zeven_user_overall_points; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_user_overall_points (
    userid numeric NOT NULL,
    points numeric,
    created_date timestamp(0) without time zone DEFAULT now(),
    updated_date timestamp(0) without time zone DEFAULT now()
);


--
