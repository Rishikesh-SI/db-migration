-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_entity_role_map labrao_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labrao_entity_role_map labrao_entity_role_map_id; Type: CONSTRAINT; Schema: labrao; Owner: -
--

ALTER TABLE ONLY labrao.labrao_entity_role_map
    ADD CONSTRAINT labrao_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
