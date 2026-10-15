-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_whatsapp_bot_quiz_ans_history
-- Type: TABLE

-- Name: labmi_whatsapp_bot_quiz_ans_history; Type: TABLE; Schema: labmi_beta_22042024; Owner: -
--

CREATE TABLE labmi_beta_22042024.labmi_whatsapp_bot_quiz_ans_history (
    mobile_no character varying(100),
    poll_id numeric,
    answer numeric,
    created_date timestamp without time zone
);


--
