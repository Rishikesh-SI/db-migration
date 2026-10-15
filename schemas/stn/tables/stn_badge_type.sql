-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_badge_type
-- Type: TABLE

-- Name: stn_badge_type; Type: TABLE; Schema: stn; Owner: -
--

CREATE TABLE stn.stn_badge_type (
    badge_type_id numeric NOT NULL,
    badge_level character(1) NOT NULL,
    badge_name text NOT NULL,
    badge_condition text NOT NULL
);


--
