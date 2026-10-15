-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_entity_role_map abp_entity_role_map_id
-- Type: CONSTRAINT

-- Name: abp_entity_role_map abp_entity_role_map_id; Type: CONSTRAINT; Schema: abpp; Owner: -
--

ALTER TABLE ONLY abpp.abp_entity_role_map
    ADD CONSTRAINT abp_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
