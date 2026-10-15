-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: gsf_entity_role_map gsf_entity_role_map_id
-- Type: CONSTRAINT

-- Name: gsf_entity_role_map gsf_entity_role_map_id; Type: CONSTRAINT; Schema: gsf; Owner: -
--

ALTER TABLE ONLY gsf.gsf_entity_role_map
    ADD CONSTRAINT gsf_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
