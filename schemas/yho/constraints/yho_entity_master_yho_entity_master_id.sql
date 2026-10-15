-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_entity_master yho_entity_master_id
-- Type: CONSTRAINT

-- Name: yho_entity_master yho_entity_master_id; Type: CONSTRAINT; Schema: yho; Owner: -
--

ALTER TABLE ONLY yho.yho_entity_master
    ADD CONSTRAINT yho_entity_master_id PRIMARY KEY (entity_master_id);


--
