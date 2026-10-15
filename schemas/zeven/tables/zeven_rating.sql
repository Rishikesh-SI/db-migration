-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_rating
-- Type: TABLE

-- Name: zeven_rating; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_rating (
    zeven_ratingid numeric NOT NULL,
    user_id numeric NOT NULL,
    venue_masterid numeric,
    venue_type numeric,
    venue_parentid numeric,
    ratings numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    zeven_comment_reviewid numeric
);


--
