-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_entity_role_map tcs_entity_role_map_id
-- Type: CONSTRAINT

-- Name: tcs_entity_role_map tcs_entity_role_map_id; Type: CONSTRAINT; Schema: tcs; Owner: -
--

ALTER TABLE ONLY tcs.tcs_entity_role_map
    ADD CONSTRAINT tcs_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
