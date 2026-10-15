-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_venue
-- Type: TABLE

-- Name: sibot_venue; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_venue (
    venue_id numeric,
    venue_name text,
    source_id numeric,
    city text,
    meta_data text,
    address text
);


--
