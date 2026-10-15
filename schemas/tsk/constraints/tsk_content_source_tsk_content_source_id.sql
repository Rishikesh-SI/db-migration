-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_content_source tsk_content_source_id
-- Type: CONSTRAINT

-- Name: tsk_content_source tsk_content_source_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_content_source
    ADD CONSTRAINT tsk_content_source_id PRIMARY KEY (content_source_id);


--
