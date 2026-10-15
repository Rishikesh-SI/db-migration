-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: gsf_entity_role gsf_entity_role_id
-- Type: CONSTRAINT

-- Name: gsf_entity_role gsf_entity_role_id; Type: CONSTRAINT; Schema: gsf; Owner: -
--

ALTER TABLE ONLY gsf.gsf_entity_role
    ADD CONSTRAINT gsf_entity_role_id PRIMARY KEY (entity_role_id);


--
