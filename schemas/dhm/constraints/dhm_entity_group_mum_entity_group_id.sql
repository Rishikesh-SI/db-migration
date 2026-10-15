-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_entity_group mum_entity_group_id
-- Type: CONSTRAINT

-- Name: dhm_entity_group mum_entity_group_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_entity_group
    ADD CONSTRAINT mum_entity_group_id PRIMARY KEY (entity_group_id);


--
