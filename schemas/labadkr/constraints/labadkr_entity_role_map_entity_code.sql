-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: labadkr_entity_role_map entity_code
-- Type: CONSTRAINT

-- Name: labadkr_entity_role_map entity_code; Type: CONSTRAINT; Schema: labadkr; Owner: -
--

ALTER TABLE ONLY labadkr.labadkr_entity_role_map
    ADD CONSTRAINT entity_code UNIQUE (entity_code);


--
