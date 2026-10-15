-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_content_source tcs_content_source_id
-- Type: CONSTRAINT

-- Name: tcs_content_source tcs_content_source_id; Type: CONSTRAINT; Schema: tcs; Owner: -
--

ALTER TABLE ONLY tcs.tcs_content_source
    ADD CONSTRAINT tcs_content_source_id PRIMARY KEY (content_source_id);


--
