-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_entity_master tsk_entity_master_id
-- Type: CONSTRAINT

-- Name: tsk_entity_master tsk_entity_master_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_entity_master
    ADD CONSTRAINT tsk_entity_master_id PRIMARY KEY (entity_master_id);


--
