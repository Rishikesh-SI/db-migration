-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_entity_master mum_entity_master_id
-- Type: CONSTRAINT

-- Name: dhm_entity_master mum_entity_master_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_entity_master
    ADD CONSTRAINT mum_entity_master_id PRIMARY KEY (entity_master_id);


--
