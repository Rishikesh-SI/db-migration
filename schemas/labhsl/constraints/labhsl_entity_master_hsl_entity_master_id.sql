-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: labhsl_entity_master hsl_entity_master_id
-- Type: CONSTRAINT

-- Name: labhsl_entity_master hsl_entity_master_id; Type: CONSTRAINT; Schema: labhsl; Owner: -
--

ALTER TABLE ONLY labhsl.labhsl_entity_master
    ADD CONSTRAINT hsl_entity_master_id PRIMARY KEY (entity_master_id);


--
