-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_provider_author_map upp_provider_author_map_id
-- Type: CONSTRAINT

-- Name: upp_provider_author_map upp_provider_author_map_id; Type: CONSTRAINT; Schema: upp; Owner: -
--

ALTER TABLE ONLY upp.upp_provider_author_map
    ADD CONSTRAINT upp_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
