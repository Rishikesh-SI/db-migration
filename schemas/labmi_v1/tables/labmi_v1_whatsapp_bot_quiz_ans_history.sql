-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_whatsapp_bot_quiz_ans_history
-- Type: TABLE

-- Name: labmi_v1_whatsapp_bot_quiz_ans_history; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_whatsapp_bot_quiz_ans_history (
    mobile_no character varying(100),
    poll_id numeric,
    answer numeric,
    created_date timestamp without time zone
);


--
