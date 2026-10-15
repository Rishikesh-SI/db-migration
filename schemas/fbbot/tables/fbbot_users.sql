-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_users
-- Type: TABLE

-- Name: fbbot_users; Type: TABLE; Schema: fbbot; Owner: -
--

CREATE TABLE fbbot.fbbot_users (
    user_id numeric NOT NULL,
    social_id text NOT NULL,
    receiver_id text,
    created_date timestamp without time zone
);


--
