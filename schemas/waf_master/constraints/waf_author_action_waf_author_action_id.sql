-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_author_action waf_author_action_id
-- Type: CONSTRAINT

-- Name: waf_author_action waf_author_action_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_author_action
    ADD CONSTRAINT waf_author_action_id PRIMARY KEY (author_action_id);


--
