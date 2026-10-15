-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_entity_role_map yho_entity_role_map_id
-- Type: CONSTRAINT

-- Name: yho_entity_role_map yho_entity_role_map_id; Type: CONSTRAINT; Schema: yho; Owner: -
--

ALTER TABLE ONLY yho.yho_entity_role_map
    ADD CONSTRAINT yho_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
