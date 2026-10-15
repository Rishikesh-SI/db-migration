-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_content_source scom_content_source_id
-- Type: CONSTRAINT

-- Name: scom_content_source scom_content_source_id; Type: CONSTRAINT; Schema: scom; Owner: -
--

ALTER TABLE ONLY scom.scom_content_source
    ADD CONSTRAINT scom_content_source_id PRIMARY KEY (content_source_id);


--
