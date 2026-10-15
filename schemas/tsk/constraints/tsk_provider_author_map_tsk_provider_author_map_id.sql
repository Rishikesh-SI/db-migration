-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_provider_author_map tsk_provider_author_map_id
-- Type: CONSTRAINT

-- Name: tsk_provider_author_map tsk_provider_author_map_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_provider_author_map
    ADD CONSTRAINT tsk_provider_author_map_id PRIMARY KEY (provider_author_map_id);


--
