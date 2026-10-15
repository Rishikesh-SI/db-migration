-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_whatsapp_bot_quiz_ans
-- Type: TABLE

-- Name: labmi_whatsapp_bot_quiz_ans; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_whatsapp_bot_quiz_ans (
    mobile_no character varying(100),
    poll_id numeric,
    answer numeric,
    created_date timestamp without time zone
);


--
