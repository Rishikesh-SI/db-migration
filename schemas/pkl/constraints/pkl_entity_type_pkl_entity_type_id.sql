-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_entity_type pkl_entity_type_id
-- Type: CONSTRAINT

-- Name: pkl_entity_type pkl_entity_type_id; Type: CONSTRAINT; Schema: pkl; Owner: -
--

ALTER TABLE ONLY pkl.pkl_entity_type
    ADD CONSTRAINT pkl_entity_type_id PRIMARY KEY (entity_type_id);


--
