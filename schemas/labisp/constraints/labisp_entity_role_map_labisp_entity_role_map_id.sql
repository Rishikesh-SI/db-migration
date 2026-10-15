-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_entity_role_map labisp_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labisp_entity_role_map labisp_entity_role_map_id; Type: CONSTRAINT; Schema: labisp; Owner: -
--

ALTER TABLE ONLY labisp.labisp_entity_role_map
    ADD CONSTRAINT labisp_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
