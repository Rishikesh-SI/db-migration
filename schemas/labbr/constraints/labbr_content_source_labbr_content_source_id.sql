-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_content_source labbr_content_source_id
-- Type: CONSTRAINT

-- Name: labbr_content_source labbr_content_source_id; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_content_source
    ADD CONSTRAINT labbr_content_source_id PRIMARY KEY (content_source_id);


--
