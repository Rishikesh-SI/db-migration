-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_seo_data waf_seo_data_id
-- Type: CONSTRAINT

-- Name: waf_seo_data waf_seo_data_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_seo_data
    ADD CONSTRAINT waf_seo_data_id PRIMARY KEY (seo_data_id);


--
