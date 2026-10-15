-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: labets_entity_role_map labets_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labets_entity_role_map labets_entity_role_map_id; Type: CONSTRAINT; Schema: labets; Owner: -
--

ALTER TABLE ONLY labets.labets_entity_role_map
    ADD CONSTRAINT labets_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
