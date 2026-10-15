-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_entity_category tfa_entity_category_id
-- Type: CONSTRAINT

-- Name: tfa_entity_category tfa_entity_category_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_entity_category
    ADD CONSTRAINT tfa_entity_category_id PRIMARY KEY (entity_category_id);


--
