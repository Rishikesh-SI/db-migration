-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_otpless_details labkc_v1_otpless_details_unique_id_key
-- Type: CONSTRAINT

-- Name: labkc_v1_otpless_details labkc_v1_otpless_details_unique_id_key; Type: CONSTRAINT; Schema: labkc_v1; Owner: -
--

ALTER TABLE ONLY labkc_v1.labkc_v1_otpless_details
    ADD CONSTRAINT labkc_v1_otpless_details_unique_id_key UNIQUE (unique_id);


--
