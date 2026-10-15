-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_topic_chunk_map gpn_topic_chunck_map_id_pk
-- Type: CONSTRAINT

-- Name: gpn_topic_chunk_map gpn_topic_chunck_map_id_pk; Type: CONSTRAINT; Schema: gpn; Owner: -
--

ALTER TABLE ONLY gpn.gpn_topic_chunk_map
    ADD CONSTRAINT gpn_topic_chunck_map_id_pk PRIMARY KEY (topic_chunk_map_id);


--
