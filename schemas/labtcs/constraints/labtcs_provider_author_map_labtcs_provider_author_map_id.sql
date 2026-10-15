-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_provider_author_map labtcs_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labtcs_provider_author_map labtcs_provider_author_map_id; Type: CONSTRAINT; Schema: labtcs; Owner: -
--

ALTER TABLE ONLY labtcs.labtcs_provider_author_map
    ADD CONSTRAINT labtcs_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
