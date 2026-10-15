-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_user_kabaddi_insider
-- Type: TABLE

-- Name: sibot_user_kabaddi_insider; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_user_kabaddi_insider (
    user_kabaddi_insider_id numeric,
    user_id numeric,
    alert_status numeric,
    alert_start_date timestamp without time zone,
    alert_stopped_date timestamp without time zone,
    alert_stopped_till timestamp without time zone
);


--
