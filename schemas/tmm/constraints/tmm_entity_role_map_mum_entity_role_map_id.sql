-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_entity_role_map mum_entity_role_map_id
-- Type: CONSTRAINT

-- Name: tmm_entity_role_map mum_entity_role_map_id; Type: CONSTRAINT; Schema: tmm; Owner: -
--

ALTER TABLE ONLY tmm.tmm_entity_role_map
    ADD CONSTRAINT mum_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
