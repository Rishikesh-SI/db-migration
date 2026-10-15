-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_asset_list_aid
-- Type: INDEX

-- Name: ix_pcm_asset_list_aid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_asset_list_aid ON pcm.pcm_asset_list USING btree (asset_id);


--
