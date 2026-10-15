-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_entity_type mum_entity_type_id
-- Type: CONSTRAINT

-- Name: dhm_entity_type mum_entity_type_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_entity_type
    ADD CONSTRAINT mum_entity_type_id PRIMARY KEY (entity_type_id);


--
