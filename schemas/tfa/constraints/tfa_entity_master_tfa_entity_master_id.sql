-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_entity_master tfa_entity_master_id
-- Type: CONSTRAINT

-- Name: tfa_entity_master tfa_entity_master_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_entity_master
    ADD CONSTRAINT tfa_entity_master_id PRIMARY KEY (entity_master_id);


--
