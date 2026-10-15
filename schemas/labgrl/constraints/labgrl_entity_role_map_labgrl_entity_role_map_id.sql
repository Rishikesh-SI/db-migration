-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_entity_role_map labgrl_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labgrl_entity_role_map labgrl_entity_role_map_id; Type: CONSTRAINT; Schema: labgrl; Owner: -
--

ALTER TABLE ONLY labgrl.labgrl_entity_role_map
    ADD CONSTRAINT labgrl_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
