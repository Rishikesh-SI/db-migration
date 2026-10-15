-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_entity_role_map labbr_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labbr_entity_role_map labbr_entity_role_map_id; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_entity_role_map
    ADD CONSTRAINT labbr_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
