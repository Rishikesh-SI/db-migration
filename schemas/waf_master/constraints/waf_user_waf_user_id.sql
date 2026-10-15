-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_user waf_user_id
-- Type: CONSTRAINT

-- Name: waf_user waf_user_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_user
    ADD CONSTRAINT waf_user_id PRIMARY KEY (user_id);


--
