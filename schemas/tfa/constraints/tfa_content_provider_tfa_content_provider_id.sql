-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_content_provider tfa_content_provider_id
-- Type: CONSTRAINT

-- Name: tfa_content_provider tfa_content_provider_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_content_provider
    ADD CONSTRAINT tfa_content_provider_id PRIMARY KEY (content_provider_id);


--
