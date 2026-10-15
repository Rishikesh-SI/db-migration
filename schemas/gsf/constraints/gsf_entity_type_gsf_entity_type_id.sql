-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: gsf_entity_type gsf_entity_type_id
-- Type: CONSTRAINT

-- Name: gsf_entity_type gsf_entity_type_id; Type: CONSTRAINT; Schema: gsf; Owner: -
--

ALTER TABLE ONLY gsf.gsf_entity_type
    ADD CONSTRAINT gsf_entity_type_id PRIMARY KEY (entity_type_id);


--
