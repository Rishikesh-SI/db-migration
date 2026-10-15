-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_entity_role_map_emid
-- Type: INDEX

-- Name: ix_pcm_entity_role_map_emid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_entity_role_map_emid ON pcm.pcm_entity_role_map USING btree (entity_master_id);


--
