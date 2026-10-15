-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: labjfc_entity_role_map labjfc_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labjfc_entity_role_map labjfc_entity_role_map_id; Type: CONSTRAINT; Schema: labjfc; Owner: -
--

ALTER TABLE ONLY labjfc.labjfc_entity_role_map
    ADD CONSTRAINT labjfc_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
