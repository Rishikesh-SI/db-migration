-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_entity_role mum_entity_role_id
-- Type: CONSTRAINT

-- Name: dhm_entity_role mum_entity_role_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_entity_role
    ADD CONSTRAINT mum_entity_role_id PRIMARY KEY (entity_role_id);


--
