-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_entity_master labrstg_entity_master_id
-- Type: CONSTRAINT

-- Name: labrstg_entity_master labrstg_entity_master_id; Type: CONSTRAINT; Schema: labrstg; Owner: -
--

ALTER TABLE ONLY labrstg.labrstg_entity_master
    ADD CONSTRAINT labrstg_entity_master_id PRIMARY KEY (entity_master_id);


--
