-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr
-- Object: labkkr_entity_role_map entity_code
-- Type: CONSTRAINT

-- Name: labkkr_entity_role_map entity_code; Type: CONSTRAINT; Schema: labkkr; Owner: -
--

ALTER TABLE ONLY labkkr.labkkr_entity_role_map
    ADD CONSTRAINT entity_code UNIQUE (entity_code);


--
