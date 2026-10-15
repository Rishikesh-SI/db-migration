-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_sms_registration_summary_sms_id_seq
-- Type: SEQUENCE

-- Name: labdd_v1_sms_registration_summary_sms_id_seq; Type: SEQUENCE; Schema: labdd_v1; Owner: -
--

ALTER TABLE labdd_v1.labdd_v1_sms_registration_summary ALTER COLUMN sms_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME labdd_v1.labdd_v1_sms_registration_summary_sms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
