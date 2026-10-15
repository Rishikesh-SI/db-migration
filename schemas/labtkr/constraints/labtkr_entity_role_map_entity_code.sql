-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr
-- Object: labtkr_entity_role_map entity_code
-- Type: CONSTRAINT

-- Name: labtkr_entity_role_map entity_code; Type: CONSTRAINT; Schema: labtkr; Owner: -
--

ALTER TABLE ONLY labtkr.labtkr_entity_role_map
    ADD CONSTRAINT entity_code UNIQUE (entity_code);


--
