-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: lb_wf_entity_master lb_wf_entity_master_id
-- Type: CONSTRAINT

-- Name: lb_wf_entity_master lb_wf_entity_master_id; Type: CONSTRAINT; Schema: lb_wf; Owner: -
--

ALTER TABLE ONLY lb_wf.lb_wf_entity_master
    ADD CONSTRAINT lb_wf_entity_master_id PRIMARY KEY (entity_master_id);


--
