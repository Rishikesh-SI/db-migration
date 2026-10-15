-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_entity_master labdv_entity_master_id
-- Type: CONSTRAINT

-- Name: labdv_entity_master labdv_entity_master_id; Type: CONSTRAINT; Schema: labdv; Owner: -
--

ALTER TABLE ONLY labdv.labdv_entity_master
    ADD CONSTRAINT labdv_entity_master_id PRIMARY KEY (entity_master_id);


--
