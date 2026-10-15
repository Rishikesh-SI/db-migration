-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_role waf_role_id
-- Type: CONSTRAINT

-- Name: waf_role waf_role_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_role
    ADD CONSTRAINT waf_role_id PRIMARY KEY (role_id);


--
