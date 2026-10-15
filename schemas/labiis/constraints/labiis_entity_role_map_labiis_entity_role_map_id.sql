-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: labiis_entity_role_map labiis_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labiis_entity_role_map labiis_entity_role_map_id; Type: CONSTRAINT; Schema: labiis; Owner: -
--

ALTER TABLE ONLY labiis.labiis_entity_role_map
    ADD CONSTRAINT labiis_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
