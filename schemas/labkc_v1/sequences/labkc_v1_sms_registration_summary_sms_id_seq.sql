-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_sms_registration_summary_sms_id_seq
-- Type: SEQUENCE

-- Name: labkc_v1_sms_registration_summary_sms_id_seq; Type: SEQUENCE; Schema: labkc_v1; Owner: -
--

ALTER TABLE labkc_v1.labkc_v1_sms_registration_summary ALTER COLUMN sms_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME labkc_v1.labkc_v1_sms_registration_summary_sms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
