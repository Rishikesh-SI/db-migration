-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_content_source mum_content_source_id
-- Type: CONSTRAINT

-- Name: dhm_content_source mum_content_source_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_content_source
    ADD CONSTRAINT mum_content_source_id PRIMARY KEY (content_source_id);


--
