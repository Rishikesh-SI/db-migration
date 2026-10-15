-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_entity_role_map labos_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labos_entity_role_map labos_entity_role_map_id; Type: CONSTRAINT; Schema: labos; Owner: -
--

ALTER TABLE ONLY labos.labos_entity_role_map
    ADD CONSTRAINT labos_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
