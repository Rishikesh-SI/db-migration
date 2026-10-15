-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_entity_master labbr_entity_master_id
-- Type: CONSTRAINT

-- Name: labbr_entity_master labbr_entity_master_id; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_entity_master
    ADD CONSTRAINT labbr_entity_master_id PRIMARY KEY (entity_master_id);


--
