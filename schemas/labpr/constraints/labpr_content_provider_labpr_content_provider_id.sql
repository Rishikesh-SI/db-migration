-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_content_provider labpr_content_provider_id
-- Type: CONSTRAINT

-- Name: labpr_content_provider labpr_content_provider_id; Type: CONSTRAINT; Schema: labpr; Owner: -
--

ALTER TABLE ONLY labpr.labpr_content_provider
    ADD CONSTRAINT labpr_content_provider_id PRIMARY KEY (content_provider_id);


--
