-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_sms_registration_summary labisl_v1_sms_registration_summary_date_key
-- Type: CONSTRAINT

-- Name: labisl_v1_sms_registration_summary labisl_v1_sms_registration_summary_date_key; Type: CONSTRAINT; Schema: labisl_v1; Owner: -
--

ALTER TABLE ONLY labisl_v1.labisl_v1_sms_registration_summary
    ADD CONSTRAINT labisl_v1_sms_registration_summary_date_key UNIQUE (date);


--
