-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_entity_role_map labdv_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labdv_entity_role_map labdv_entity_role_map_id; Type: CONSTRAINT; Schema: labdv; Owner: -
--

ALTER TABLE ONLY labdv.labdv_entity_role_map
    ADD CONSTRAINT labdv_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
