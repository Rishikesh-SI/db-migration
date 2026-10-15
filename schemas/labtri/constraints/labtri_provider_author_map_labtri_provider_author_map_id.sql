-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_provider_author_map labtri_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labtri_provider_author_map labtri_provider_author_map_id; Type: CONSTRAINT; Schema: labtri; Owner: -
--

ALTER TABLE ONLY labtri.labtri_provider_author_map
    ADD CONSTRAINT labtri_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
