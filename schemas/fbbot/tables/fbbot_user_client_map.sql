-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_user_client_map
-- Type: TABLE

-- Name: fbbot_user_client_map; Type: TABLE; Schema: fbbot; Owner: -
--

CREATE TABLE fbbot.fbbot_user_client_map (
    user_client_map_id numeric NOT NULL,
    user_id numeric NOT NULL,
    client_id numeric NOT NULL
);


--
