-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_entity_role_map entity_code
-- Type: CONSTRAINT

-- Name: labkkr_v1_entity_role_map entity_code; Type: CONSTRAINT; Schema: labkkr_v1; Owner: -
--

ALTER TABLE ONLY labkkr_v1.labkkr_v1_entity_role_map
    ADD CONSTRAINT entity_code UNIQUE (entity_code);


--
