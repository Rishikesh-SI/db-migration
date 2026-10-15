-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_content_provider mum_content_provider_id
-- Type: CONSTRAINT

-- Name: tmm_content_provider mum_content_provider_id; Type: CONSTRAINT; Schema: tmm; Owner: -
--

ALTER TABLE ONLY tmm.tmm_content_provider
    ADD CONSTRAINT mum_content_provider_id PRIMARY KEY (content_provider_id);


--
