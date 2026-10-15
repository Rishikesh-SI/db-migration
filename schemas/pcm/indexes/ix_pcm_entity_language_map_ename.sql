-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_entity_language_map_ename
-- Type: INDEX

-- Name: ix_pcm_entity_language_map_ename; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_entity_language_map_ename ON pcm.pcm_entity_language_map USING btree (entity_name);


--
