-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_provider_author_map labmi_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labmi_provider_author_map labmi_provider_author_map_id; Type: CONSTRAINT; Schema: labmi; Owner: -
--

ALTER TABLE ONLY labmi.labmi_provider_author_map
    ADD CONSTRAINT labmi_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
