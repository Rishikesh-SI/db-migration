-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: ix_gpn_topic_chunk_map_tidcid
-- Type: INDEX

-- Name: ix_gpn_topic_chunk_map_tidcid; Type: INDEX; Schema: gpn; Owner: -
--

CREATE INDEX ix_gpn_topic_chunk_map_tidcid ON gpn.gpn_topic_chunk_map USING btree (topic_id, chunk_id);


--
