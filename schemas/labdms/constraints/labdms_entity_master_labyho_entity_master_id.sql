-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_entity_master labyho_entity_master_id
-- Type: CONSTRAINT

-- Name: labdms_entity_master labyho_entity_master_id; Type: CONSTRAINT; Schema: labdms; Owner: -
--

ALTER TABLE ONLY labdms.labdms_entity_master
    ADD CONSTRAINT labyho_entity_master_id PRIMARY KEY (entity_master_id);


--
