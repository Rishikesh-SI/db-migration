-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_web_user labgt_web_user_mobile_no_country_code_key
-- Type: CONSTRAINT

-- Name: labgt01_v1_web_user labgt_web_user_mobile_no_country_code_key; Type: CONSTRAINT; Schema: labgt01_v1; Owner: -
--

ALTER TABLE ONLY labgt01_v1.labgt01_v1_web_user
    ADD CONSTRAINT labgt_web_user_mobile_no_country_code_key UNIQUE (mobile_no, country_code);


--
