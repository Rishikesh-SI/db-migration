-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_content_source stn_content_source_id
-- Type: CONSTRAINT

-- Name: stn_content_source stn_content_source_id; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_content_source
    ADD CONSTRAINT stn_content_source_id PRIMARY KEY (content_source_id);


--
