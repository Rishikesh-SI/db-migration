-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: labfg_entity_role_map labfg_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labfg_entity_role_map labfg_entity_role_map_id; Type: CONSTRAINT; Schema: labfg; Owner: -
--

ALTER TABLE ONLY labfg.labfg_entity_role_map
    ADD CONSTRAINT labfg_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
