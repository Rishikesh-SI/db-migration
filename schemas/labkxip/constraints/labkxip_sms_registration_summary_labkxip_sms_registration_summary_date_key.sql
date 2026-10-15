-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_sms_registration_summary labkxip_sms_registration_summary_date_key
-- Type: CONSTRAINT

-- Name: labkxip_sms_registration_summary labkxip_sms_registration_summary_date_key; Type: CONSTRAINT; Schema: labkxip; Owner: -
--

ALTER TABLE ONLY labkxip.labkxip_sms_registration_summary
    ADD CONSTRAINT labkxip_sms_registration_summary_date_key UNIQUE (date);


--
