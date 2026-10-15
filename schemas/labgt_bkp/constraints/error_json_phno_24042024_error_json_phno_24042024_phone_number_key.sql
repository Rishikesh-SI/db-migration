-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: error_json_phno_24042024 error_json_phno_24042024_phone_number_key
-- Type: CONSTRAINT

-- Name: error_json_phno_24042024 error_json_phno_24042024_phone_number_key; Type: CONSTRAINT; Schema: labgt_bkp; Owner: -
--

ALTER TABLE ONLY labgt_bkp.error_json_phno_24042024
    ADD CONSTRAINT error_json_phno_24042024_phone_number_key UNIQUE (phone_number);


--
