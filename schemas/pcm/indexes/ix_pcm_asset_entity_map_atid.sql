-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_asset_entity_map_atid
-- Type: INDEX

-- Name: ix_pcm_asset_entity_map_atid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_asset_entity_map_atid ON pcm.pcm_asset_entity_map USING btree (asset_type_id);


--
