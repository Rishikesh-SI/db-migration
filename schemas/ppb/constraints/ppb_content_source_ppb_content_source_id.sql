-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ppb_content_source ppb_content_source_id
-- Type: CONSTRAINT

-- Name: ppb_content_source ppb_content_source_id; Type: CONSTRAINT; Schema: ppb; Owner: -
--

ALTER TABLE ONLY ppb.ppb_content_source
    ADD CONSTRAINT ppb_content_source_id PRIMARY KEY (content_source_id);


--
