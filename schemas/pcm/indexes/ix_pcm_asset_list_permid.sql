-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_asset_list_permid
-- Type: INDEX

-- Name: ix_pcm_asset_list_permid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_asset_list_permid ON pcm.pcm_asset_list USING btree (primary_entity_role_map_id);


--
