-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_entity_role_map labgsoc_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labgsoc_entity_role_map labgsoc_entity_role_map_id; Type: CONSTRAINT; Schema: labgsoc; Owner: -
--

ALTER TABLE ONLY labgsoc.labgsoc_entity_role_map
    ADD CONSTRAINT labgsoc_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
