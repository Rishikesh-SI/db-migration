-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_asset_entity_map_uqid
-- Type: INDEX

-- Name: ix_pcm_asset_entity_map_uqid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE UNIQUE INDEX ix_pcm_asset_entity_map_uqid ON pcm.pcm_asset_entity_map USING btree (asset_id, asset_type_id, entity_role_map_id);


--
