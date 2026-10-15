-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_provider_author_map labpc_provider_author_map_id
-- Type: CONSTRAINT

-- Name: labpc_provider_author_map labpc_provider_author_map_id; Type: CONSTRAINT; Schema: labpc; Owner: -
--

ALTER TABLE ONLY labpc.labpc_provider_author_map
    ADD CONSTRAINT labpc_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
