-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_provider_author_map labdsg_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labdsg_provider_author_map labdsg_provider_author_map_id; Type: CONSTRAINT; Schema: labdsg; Owner: -
--

ALTER TABLE ONLY labdsg.labdsg_provider_author_map
    ADD CONSTRAINT labdsg_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
