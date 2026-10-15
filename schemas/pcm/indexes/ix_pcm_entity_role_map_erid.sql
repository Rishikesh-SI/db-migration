-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_entity_role_map_erid
-- Type: INDEX

-- Name: ix_pcm_entity_role_map_erid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_entity_role_map_erid ON pcm.pcm_entity_role_map USING btree (entity_role_id);


--
