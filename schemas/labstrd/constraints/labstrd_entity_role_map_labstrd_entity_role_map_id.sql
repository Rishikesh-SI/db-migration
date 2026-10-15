-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_entity_role_map labstrd_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labstrd_entity_role_map labstrd_entity_role_map_id; Type: CONSTRAINT; Schema: labstrd; Owner: -
--

ALTER TABLE ONLY labstrd.labstrd_entity_role_map
    ADD CONSTRAINT labstrd_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
