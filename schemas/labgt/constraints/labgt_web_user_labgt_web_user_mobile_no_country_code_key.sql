-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_web_user labgt_web_user_mobile_no_country_code_key
-- Type: CONSTRAINT

-- Name: labgt_web_user labgt_web_user_mobile_no_country_code_key; Type: CONSTRAINT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_web_user
    ADD CONSTRAINT labgt_web_user_mobile_no_country_code_key UNIQUE (mobile_no, country_code);


--
