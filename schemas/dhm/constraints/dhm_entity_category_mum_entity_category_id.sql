-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_entity_category mum_entity_category_id
-- Type: CONSTRAINT

-- Name: dhm_entity_category mum_entity_category_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_entity_category
    ADD CONSTRAINT mum_entity_category_id PRIMARY KEY (entity_category_id);


--
