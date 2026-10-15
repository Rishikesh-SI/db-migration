-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_sms_registration_summary_sms_id_seq
-- Type: SEQUENCE

-- Name: labkxip_sms_registration_summary_sms_id_seq; Type: SEQUENCE; Schema: labkxip; Owner: -
--

ALTER TABLE labkxip.labkxip_sms_registration_summary ALTER COLUMN sms_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME labkxip.labkxip_sms_registration_summary_sms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
