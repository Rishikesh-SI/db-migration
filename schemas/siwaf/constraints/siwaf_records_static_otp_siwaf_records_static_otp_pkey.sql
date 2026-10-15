-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_records_static_otp siwaf_records_static_otp_pkey
-- Type: CONSTRAINT

-- Name: siwaf_records_static_otp siwaf_records_static_otp_pkey; Type: CONSTRAINT; Schema: siwaf; Owner: -
--

ALTER TABLE ONLY siwaf.siwaf_records_static_otp
    ADD CONSTRAINT siwaf_records_static_otp_pkey PRIMARY KEY (mobile_no);


--
