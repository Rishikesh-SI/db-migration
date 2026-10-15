-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: msl_entity_master msl_entity_master_id
-- Type: CONSTRAINT

-- Name: msl_entity_master msl_entity_master_id; Type: CONSTRAINT; Schema: msl; Owner: -
--

ALTER TABLE ONLY msl.msl_entity_master
    ADD CONSTRAINT msl_entity_master_id PRIMARY KEY (entity_master_id);


--
