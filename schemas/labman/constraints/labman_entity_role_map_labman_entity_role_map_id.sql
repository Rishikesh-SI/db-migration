-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: labman_entity_role_map labman_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labman_entity_role_map labman_entity_role_map_id; Type: CONSTRAINT; Schema: labman; Owner: -
--

ALTER TABLE ONLY labman.labman_entity_role_map
    ADD CONSTRAINT labman_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
