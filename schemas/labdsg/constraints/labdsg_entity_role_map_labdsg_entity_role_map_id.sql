-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_entity_role_map labdsg_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labdsg_entity_role_map labdsg_entity_role_map_id; Type: CONSTRAINT; Schema: labdsg; Owner: -
--

ALTER TABLE ONLY labdsg.labdsg_entity_role_map
    ADD CONSTRAINT labdsg_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
