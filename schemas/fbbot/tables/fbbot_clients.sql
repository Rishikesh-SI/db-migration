-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_clients
-- Type: TABLE

-- Name: fbbot_clients; Type: TABLE; Schema: fbbot; Owner: -
--

CREATE TABLE fbbot.fbbot_clients (
    client_id numeric NOT NULL,
    client_name text NOT NULL,
    client_unique_id text NOT NULL
);


--
