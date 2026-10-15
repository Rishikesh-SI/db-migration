-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_entity_type yho_entity_type_id
-- Type: CONSTRAINT

-- Name: yho_entity_type yho_entity_type_id; Type: CONSTRAINT; Schema: yho; Owner: -
--

ALTER TABLE ONLY yho.yho_entity_type
    ADD CONSTRAINT yho_entity_type_id PRIMARY KEY (entity_type_id);


--
