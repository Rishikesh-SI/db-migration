-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: gsf_entity_master gsf_entity_master_id
-- Type: CONSTRAINT

-- Name: gsf_entity_master gsf_entity_master_id; Type: CONSTRAINT; Schema: gsf; Owner: -
--

ALTER TABLE ONLY gsf.gsf_entity_master
    ADD CONSTRAINT gsf_entity_master_id PRIMARY KEY (entity_master_id);


--
