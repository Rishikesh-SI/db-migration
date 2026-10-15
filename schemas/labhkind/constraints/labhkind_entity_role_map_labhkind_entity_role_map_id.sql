-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_entity_role_map labhkind_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labhkind_entity_role_map labhkind_entity_role_map_id; Type: CONSTRAINT; Schema: labhkind; Owner: -
--

ALTER TABLE ONLY labhkind.labhkind_entity_role_map
    ADD CONSTRAINT labhkind_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
