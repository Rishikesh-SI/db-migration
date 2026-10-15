-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_provider_author_map labgt_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labgt_provider_author_map labgt_provider_author_map_id; Type: CONSTRAINT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_provider_author_map
    ADD CONSTRAINT labgt_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
