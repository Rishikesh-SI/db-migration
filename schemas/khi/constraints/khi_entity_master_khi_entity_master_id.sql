-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_entity_master khi_entity_master_id
-- Type: CONSTRAINT

-- Name: khi_entity_master khi_entity_master_id; Type: CONSTRAINT; Schema: khi; Owner: -
--

ALTER TABLE ONLY khi.khi_entity_master
    ADD CONSTRAINT khi_entity_master_id PRIMARY KEY (entity_master_id);


--
