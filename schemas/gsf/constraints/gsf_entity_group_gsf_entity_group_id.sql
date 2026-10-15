-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: gsf_entity_group gsf_entity_group_id
-- Type: CONSTRAINT

-- Name: gsf_entity_group gsf_entity_group_id; Type: CONSTRAINT; Schema: gsf; Owner: -
--

ALTER TABLE ONLY gsf.gsf_entity_group
    ADD CONSTRAINT gsf_entity_group_id PRIMARY KEY (entity_group_id);


--
