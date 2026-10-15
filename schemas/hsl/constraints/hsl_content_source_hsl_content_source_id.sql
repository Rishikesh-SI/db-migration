-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_content_source hsl_content_source_id
-- Type: CONSTRAINT

-- Name: hsl_content_source hsl_content_source_id; Type: CONSTRAINT; Schema: hsl; Owner: -
--

ALTER TABLE ONLY hsl.hsl_content_source
    ADD CONSTRAINT hsl_content_source_id PRIMARY KEY (content_source_id);


--
