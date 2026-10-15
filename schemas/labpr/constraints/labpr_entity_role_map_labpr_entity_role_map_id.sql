-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_entity_role_map labpr_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labpr_entity_role_map labpr_entity_role_map_id; Type: CONSTRAINT; Schema: labpr; Owner: -
--

ALTER TABLE ONLY labpr.labpr_entity_role_map
    ADD CONSTRAINT labpr_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
