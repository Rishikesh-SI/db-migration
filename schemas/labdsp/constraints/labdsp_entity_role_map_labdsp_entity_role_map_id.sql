-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: labdsp_entity_role_map labdsp_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labdsp_entity_role_map labdsp_entity_role_map_id; Type: CONSTRAINT; Schema: labdsp; Owner: -
--

ALTER TABLE ONLY labdsp.labdsp_entity_role_map
    ADD CONSTRAINT labdsp_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
