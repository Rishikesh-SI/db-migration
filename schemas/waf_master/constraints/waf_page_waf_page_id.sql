-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_page waf_page_id
-- Type: CONSTRAINT

-- Name: waf_page waf_page_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_page
    ADD CONSTRAINT waf_page_id PRIMARY KEY (page_id);


--
