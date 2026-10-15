-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_kid_badges
-- Type: TABLE

-- Name: stn_kid_badges; Type: TABLE; Schema: stn; Owner: -
--

CREATE TABLE stn.stn_kid_badges (
    kid_badges_id numeric NOT NULL,
    kid_id numeric NOT NULL,
    badge_id numeric NOT NULL,
    badge_awarded_on timestamp without time zone NOT NULL
);


--
