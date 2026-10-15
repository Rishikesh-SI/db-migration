-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_redirect waf_redirect_id
-- Type: CONSTRAINT

-- Name: waf_redirect waf_redirect_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_redirect
    ADD CONSTRAINT waf_redirect_id PRIMARY KEY (redirect_id);


--
