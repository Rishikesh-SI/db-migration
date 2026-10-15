-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_content_source waf_content_source_id
-- Type: CONSTRAINT

-- Name: waf_content_source waf_content_source_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_content_source
    ADD CONSTRAINT waf_content_source_id PRIMARY KEY (content_source_id);


--
