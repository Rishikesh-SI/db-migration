-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: kxp_entity_master kxp_entity_master_id
-- Type: CONSTRAINT

-- Name: kxp_entity_master kxp_entity_master_id; Type: CONSTRAINT; Schema: kxp; Owner: -
--

ALTER TABLE ONLY kxp.kxp_entity_master
    ADD CONSTRAINT kxp_entity_master_id PRIMARY KEY (entity_master_id);


--
