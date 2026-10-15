-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_content_provider mum_content_provider_id
-- Type: CONSTRAINT

-- Name: dhm_content_provider mum_content_provider_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_content_provider
    ADD CONSTRAINT mum_content_provider_id PRIMARY KEY (content_provider_id);


--
