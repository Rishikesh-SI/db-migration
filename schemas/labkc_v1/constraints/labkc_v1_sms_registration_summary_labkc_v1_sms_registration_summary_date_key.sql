-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_sms_registration_summary labkc_v1_sms_registration_summary_date_key
-- Type: CONSTRAINT

-- Name: labkc_v1_sms_registration_summary labkc_v1_sms_registration_summary_date_key; Type: CONSTRAINT; Schema: labkc_v1; Owner: -
--

ALTER TABLE ONLY labkc_v1.labkc_v1_sms_registration_summary
    ADD CONSTRAINT labkc_v1_sms_registration_summary_date_key UNIQUE (date);


--
