-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_cooment_review
-- Type: TABLE

-- Name: zeven_cooment_review; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_cooment_review (
    zeven_comment_reviewid numeric NOT NULL,
    userid numeric NOT NULL,
    venue_masterid numeric,
    venue_type numeric,
    venue_parentid numeric,
    type numeric,
    comment_review_text character varying(4000),
    been_played_there numeric,
    reply_to_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    comment_review_title character varying(1000),
    is_published numeric
);


--
