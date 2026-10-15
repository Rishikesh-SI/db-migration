-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_entity_master labstrd_entity_master_id
-- Type: CONSTRAINT

-- Name: labstrd_entity_master labstrd_entity_master_id; Type: CONSTRAINT; Schema: labstrd; Owner: -
--

ALTER TABLE ONLY labstrd.labstrd_entity_master
    ADD CONSTRAINT labstrd_entity_master_id PRIMARY KEY (entity_master_id);


--
