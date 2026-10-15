-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: labwf_entity_role_map labwf_entity_role_map_id
-- Type: CONSTRAINT

-- Name: labwf_entity_role_map labwf_entity_role_map_id; Type: CONSTRAINT; Schema: labwf; Owner: -
--

ALTER TABLE ONLY labwf.labwf_entity_role_map
    ADD CONSTRAINT labwf_entity_role_map_id PRIMARY KEY (entity_role_map_id);


--
