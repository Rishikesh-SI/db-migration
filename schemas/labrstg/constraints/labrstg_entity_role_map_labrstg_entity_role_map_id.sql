-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_entity_role_map labrstg_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labrstg_entity_role_map labrstg_entity_role_map_id; Type: CONSTRAINT; Schema: labrstg; Owner: -
--

ALTER TABLE ONLY labrstg.labrstg_entity_role_map
    ADD CONSTRAINT labrstg_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
