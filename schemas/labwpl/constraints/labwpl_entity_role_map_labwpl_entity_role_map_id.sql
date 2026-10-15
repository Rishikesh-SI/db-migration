-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_entity_role_map labwpl_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labwpl_entity_role_map labwpl_entity_role_map_id; Type: CONSTRAINT; Schema: labwpl; Owner: -
--

ALTER TABLE ONLY labwpl.labwpl_entity_role_map
    ADD CONSTRAINT labwpl_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
