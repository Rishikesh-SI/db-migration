-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_provider_author_map labisp_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labisp_provider_author_map labisp_provider_author_map_id; Type: CONSTRAINT; Schema: labisp; Owner: -
--

ALTER TABLE ONLY labisp.labisp_provider_author_map
    ADD CONSTRAINT labisp_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
