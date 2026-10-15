-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_site_master waf_site_master_id
-- Type: CONSTRAINT

-- Name: waf_site_master waf_site_master_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_site_master
    ADD CONSTRAINT waf_site_master_id PRIMARY KEY (site_master_id);


--
