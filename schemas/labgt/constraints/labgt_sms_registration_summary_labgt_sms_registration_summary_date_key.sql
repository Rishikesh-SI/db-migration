-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_sms_registration_summary labgt_sms_registration_summary_date_key
-- Type: CONSTRAINT

-- Name: labgt_sms_registration_summary labgt_sms_registration_summary_date_key; Type: CONSTRAINT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_sms_registration_summary
    ADD CONSTRAINT labgt_sms_registration_summary_date_key UNIQUE (date);


--
