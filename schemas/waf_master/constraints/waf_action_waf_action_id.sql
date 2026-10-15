-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_action waf_action_id
-- Type: CONSTRAINT

-- Name: waf_action waf_action_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_action
    ADD CONSTRAINT waf_action_id PRIMARY KEY (action_id);


--
