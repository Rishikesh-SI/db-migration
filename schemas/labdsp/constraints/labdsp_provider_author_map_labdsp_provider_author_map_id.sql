-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: labdsp_provider_author_map labdsp_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labdsp_provider_author_map labdsp_provider_author_map_id; Type: CONSTRAINT; Schema: labdsp; Owner: -
--

ALTER TABLE ONLY labdsp.labdsp_provider_author_map
    ADD CONSTRAINT labdsp_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
