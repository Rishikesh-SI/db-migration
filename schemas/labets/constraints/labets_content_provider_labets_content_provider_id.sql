-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: labets_content_provider labets_content_provider_id
-- Type: CONSTRAINT

-- Name: labets_content_provider labets_content_provider_id; Type: CONSTRAINT; Schema: labets; Owner: -
--

ALTER TABLE ONLY labets.labets_content_provider
    ADD CONSTRAINT labets_content_provider_id PRIMARY KEY (content_provider_id);


--
