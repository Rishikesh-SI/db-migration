-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_otp_details labmi_otp_details_unique_id_key
-- Type: CONSTRAINT

-- Name: labmi_otp_details labmi_otp_details_unique_id_key; Type: CONSTRAINT; Schema: labmi; Owner: -
--

ALTER TABLE ONLY labmi.labmi_otp_details
    ADD CONSTRAINT labmi_otp_details_unique_id_key UNIQUE (unique_id);


--
