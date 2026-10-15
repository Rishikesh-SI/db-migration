-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_provider_author_map tcs_provider_author_map_id
-- Type: CONSTRAINT

-- Name: tcs_provider_author_map tcs_provider_author_map_id; Type: CONSTRAINT; Schema: tcs; Owner: -
--

ALTER TABLE ONLY tcs.tcs_provider_author_map
    ADD CONSTRAINT tcs_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
