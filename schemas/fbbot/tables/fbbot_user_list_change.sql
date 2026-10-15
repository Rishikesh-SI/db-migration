-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_user_list_change
-- Type: TABLE

-- Name: fbbot_user_list_change; Type: TABLE; Schema: fbbot; Owner: -
--

CREATE TABLE fbbot.fbbot_user_list_change (
    user_list_change_id numeric NOT NULL,
    user_id numeric NOT NULL,
    list_id numeric NOT NULL,
    status numeric,
    alert_stopped_till timestamp without time zone
);


--
