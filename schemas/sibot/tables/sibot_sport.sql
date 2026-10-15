-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_sport
-- Type: TABLE

-- Name: sibot_sport; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_sport (
    sport_id numeric,
    sport_name text,
    sport_payload_text text,
    meta_data text,
    status numeric,
    created_date date,
    updated_date date
);


--
