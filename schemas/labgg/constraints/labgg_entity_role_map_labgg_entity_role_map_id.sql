-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: labgg_entity_role_map labgg_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labgg_entity_role_map labgg_entity_role_map_id; Type: CONSTRAINT; Schema: labgg; Owner: -
--

ALTER TABLE ONLY labgg.labgg_entity_role_map
    ADD CONSTRAINT labgg_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
