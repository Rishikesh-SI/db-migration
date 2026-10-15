-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_provider_author_map labhkind_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labhkind_provider_author_map labhkind_provider_author_map_id; Type: CONSTRAINT; Schema: labhkind; Owner: -
--

ALTER TABLE ONLY labhkind.labhkind_provider_author_map
    ADD CONSTRAINT labhkind_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
