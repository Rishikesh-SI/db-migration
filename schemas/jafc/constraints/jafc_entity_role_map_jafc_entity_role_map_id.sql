-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_entity_role_map jafc_entity_role_map_id
-- Type: CONSTRAINT

-- Name: jafc_entity_role_map jafc_entity_role_map_id; Type: CONSTRAINT; Schema: jafc; Owner: -
--

ALTER TABLE ONLY jafc.jafc_entity_role_map
    ADD CONSTRAINT jafc_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
