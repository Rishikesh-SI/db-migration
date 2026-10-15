-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_template waf_template_id
-- Type: CONSTRAINT

-- Name: waf_template waf_template_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_template
    ADD CONSTRAINT waf_template_id PRIMARY KEY (template_id);


--
