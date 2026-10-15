-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_sms_registration_summary labgt01_v1_sms_registration_summary_date_key
-- Type: CONSTRAINT

-- Name: labgt01_v1_sms_registration_summary labgt01_v1_sms_registration_summary_date_key; Type: CONSTRAINT; Schema: labgt01_v1; Owner: -
--

ALTER TABLE ONLY labgt01_v1.labgt01_v1_sms_registration_summary
    ADD CONSTRAINT labgt01_v1_sms_registration_summary_date_key UNIQUE (date);


--
