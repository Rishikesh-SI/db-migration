-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_content_provider hsl_content_provider_id
-- Type: CONSTRAINT

-- Name: hsl_content_provider hsl_content_provider_id; Type: CONSTRAINT; Schema: hsl; Owner: -
--

ALTER TABLE ONLY hsl.hsl_content_provider
    ADD CONSTRAINT hsl_content_provider_id PRIMARY KEY (content_provider_id);


--
