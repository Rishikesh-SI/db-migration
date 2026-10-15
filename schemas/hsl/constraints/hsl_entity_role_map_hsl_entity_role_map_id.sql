-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_entity_role_map hsl_entity_role_map_id
-- Type: CONSTRAINT

-- Name: hsl_entity_role_map hsl_entity_role_map_id; Type: CONSTRAINT; Schema: hsl; Owner: -
--

ALTER TABLE ONLY hsl.hsl_entity_role_map
    ADD CONSTRAINT hsl_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
