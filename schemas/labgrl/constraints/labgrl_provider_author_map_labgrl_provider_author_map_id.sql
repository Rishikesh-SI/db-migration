-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_provider_author_map labgrl_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labgrl_provider_author_map labgrl_provider_author_map_id; Type: CONSTRAINT; Schema: labgrl; Owner: -
--

ALTER TABLE ONLY labgrl.labgrl_provider_author_map
    ADD CONSTRAINT labgrl_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
