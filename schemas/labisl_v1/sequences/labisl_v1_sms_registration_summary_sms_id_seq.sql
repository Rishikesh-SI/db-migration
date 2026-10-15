-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_sms_registration_summary_sms_id_seq
-- Type: SEQUENCE

-- Name: labisl_v1_sms_registration_summary_sms_id_seq; Type: SEQUENCE; Schema: labisl_v1; Owner: -
--

ALTER TABLE labisl_v1.labisl_v1_sms_registration_summary ALTER COLUMN sms_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME labisl_v1.labisl_v1_sms_registration_summary_sms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
