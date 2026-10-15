-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_entity_role_map labstmp_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labstmp_entity_role_map labstmp_entity_role_map_id; Type: CONSTRAINT; Schema: labstmp; Owner: -
--

ALTER TABLE ONLY labstmp.labstmp_entity_role_map
    ADD CONSTRAINT labstmp_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
