-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_entity_master tcs_entity_master_id
-- Type: CONSTRAINT

-- Name: tcs_entity_master tcs_entity_master_id; Type: CONSTRAINT; Schema: tcs; Owner: -
--

ALTER TABLE ONLY tcs.tcs_entity_master
    ADD CONSTRAINT tcs_entity_master_id PRIMARY KEY (entity_master_id);


--
