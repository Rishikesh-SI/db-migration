-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_provider_author_map mum_provider_author_map_id
-- Type: CONSTRAINT

-- Name: tmm_provider_author_map mum_provider_author_map_id; Type: CONSTRAINT; Schema: tmm; Owner: -
--

ALTER TABLE ONLY tmm.tmm_provider_author_map
    ADD CONSTRAINT mum_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
