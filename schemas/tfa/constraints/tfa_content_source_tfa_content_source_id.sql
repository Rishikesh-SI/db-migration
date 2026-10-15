-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_content_source tfa_content_source_id
-- Type: CONSTRAINT

-- Name: tfa_content_source tfa_content_source_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_content_source
    ADD CONSTRAINT tfa_content_source_id PRIMARY KEY (content_source_id);


--
