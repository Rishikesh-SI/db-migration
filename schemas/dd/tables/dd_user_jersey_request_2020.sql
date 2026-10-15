-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_user_jersey_request_2020
-- Type: TABLE

-- Name: dd_user_jersey_request_2020; Type: TABLE; Schema: dd; Owner: -
--

CREATE TABLE dd.dd_user_jersey_request_2020 (
    jersey_request_id numeric,
    user_id numeric,
    email_id text,
    jersey_number numeric,
    player_name character varying(500),
    favorite_player character varying(500),
    created_date timestamp without time zone
);


--
