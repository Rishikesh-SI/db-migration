-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: msl_entity_type msl_entity_type_id
-- Type: CONSTRAINT

-- Name: msl_entity_type msl_entity_type_id; Type: CONSTRAINT; Schema: msl; Owner: -
--

ALTER TABLE ONLY msl.msl_entity_type
    ADD CONSTRAINT msl_entity_type_id PRIMARY KEY (entity_type_id);


--
