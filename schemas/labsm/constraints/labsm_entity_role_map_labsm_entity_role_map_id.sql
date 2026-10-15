-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: labsm_entity_role_map labsm_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labsm_entity_role_map labsm_entity_role_map_id; Type: CONSTRAINT; Schema: labsm; Owner: -
--

ALTER TABLE ONLY labsm.labsm_entity_role_map
    ADD CONSTRAINT labsm_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
