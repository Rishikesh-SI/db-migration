-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_user_jersey_request
-- Type: TABLE

-- Name: dd_user_jersey_request; Type: TABLE; Schema: dd_30_04_24; Owner: -
--

CREATE TABLE dd_30_04_24.dd_user_jersey_request (
    jersey_request_id numeric NOT NULL,
    user_id numeric,
    email_id text,
    jersey_number numeric,
    player_name character varying(500),
    favorite_player character varying(500),
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
