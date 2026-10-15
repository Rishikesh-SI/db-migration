-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr_beta
-- Object: labtkr_provider_author_map labtkr_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labtkr_provider_author_map labtkr_provider_author_map_id; Type: CONSTRAINT; Schema: labtkr_beta; Owner: -
--

ALTER TABLE ONLY labtkr_beta.labtkr_provider_author_map
    ADD CONSTRAINT labtkr_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
