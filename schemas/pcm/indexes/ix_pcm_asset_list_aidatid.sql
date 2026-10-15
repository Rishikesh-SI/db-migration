-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_asset_list_aidatid
-- Type: INDEX

-- Name: ix_pcm_asset_list_aidatid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_asset_list_aidatid ON pcm.pcm_asset_list USING btree (asset_id, asset_type_id);


--
