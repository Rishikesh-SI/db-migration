-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_entity_master swa_entity_master_id
-- Type: CONSTRAINT

-- Name: swa_entity_master swa_entity_master_id; Type: CONSTRAINT; Schema: swa; Owner: -
--

ALTER TABLE ONLY swa.swa_entity_master
    ADD CONSTRAINT swa_entity_master_id PRIMARY KEY (entity_master_id);


--
