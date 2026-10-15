-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_entity_master isl_entity_master_id
-- Type: CONSTRAINT

-- Name: isl_entity_master isl_entity_master_id; Type: CONSTRAINT; Schema: isl; Owner: -
--

ALTER TABLE ONLY isl.isl_entity_master
    ADD CONSTRAINT isl_entity_master_id PRIMARY KEY (entity_master_id);


--
