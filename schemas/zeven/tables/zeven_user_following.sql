-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_user_following
-- Type: TABLE

-- Name: zeven_user_following; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_user_following (
    user_following_id numeric NOT NULL,
    user_id numeric NOT NULL,
    following_id numeric,
    created_date timestamp(6) without time zone NOT NULL,
    modified_date timestamp(6) without time zone,
    is_active numeric
);


--
