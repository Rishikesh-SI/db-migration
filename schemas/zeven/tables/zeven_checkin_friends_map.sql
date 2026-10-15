-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_checkin_friends_map
-- Type: TABLE

-- Name: zeven_checkin_friends_map; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_checkin_friends_map (
    checkin_friend_map_id numeric NOT NULL,
    zeven_venue_checkinsid numeric,
    user_id numeric,
    friend_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
