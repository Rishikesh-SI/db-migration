-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: labetpl_entity_role_map labetpl_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labetpl_entity_role_map labetpl_entity_role_map_id; Type: CONSTRAINT; Schema: labetpl; Owner: -
--

ALTER TABLE ONLY labetpl.labetpl_entity_role_map
    ADD CONSTRAINT labetpl_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
