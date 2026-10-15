-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_want_to_play
-- Type: TABLE

-- Name: zeven_want_to_play; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_want_to_play (
    zeven_want_to_playid numeric NOT NULL,
    user_id numeric,
    sport_masterid numeric,
    venue_masterid numeric,
    play_date date,
    is_active numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
