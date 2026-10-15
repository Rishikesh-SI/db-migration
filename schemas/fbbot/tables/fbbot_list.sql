-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_list
-- Type: TABLE

-- Name: fbbot_list; Type: TABLE; Schema: fbbot; Owner: -
--

CREATE TABLE fbbot.fbbot_list (
    list_id numeric NOT NULL,
    list_name text NOT NULL,
    list_unique_id numeric
);


--
