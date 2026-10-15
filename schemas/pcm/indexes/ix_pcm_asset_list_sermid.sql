-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_asset_list_sermid
-- Type: INDEX

-- Name: ix_pcm_asset_list_sermid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_asset_list_sermid ON pcm.pcm_asset_list USING btree (secondary_entity_role_map_id);


--
