-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_asset_list_atid
-- Type: INDEX

-- Name: ix_pcm_asset_list_atid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_asset_list_atid ON pcm.pcm_asset_list USING btree (asset_type_id);


--
