-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_provider_author_map labyho_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labdms_provider_author_map labyho_provider_author_map_id; Type: CONSTRAINT; Schema: labdms; Owner: -
--

ALTER TABLE ONLY labdms.labdms_provider_author_map
    ADD CONSTRAINT labyho_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
