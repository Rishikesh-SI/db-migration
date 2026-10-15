-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_content_provider stn_content_provider_id
-- Type: CONSTRAINT

-- Name: stn_content_provider stn_content_provider_id; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_content_provider
    ADD CONSTRAINT stn_content_provider_id PRIMARY KEY (content_provider_id);


--
