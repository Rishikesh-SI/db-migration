-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_asset_list_title_alias
-- Type: INDEX

-- Name: ix_pcm_asset_list_title_alias; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_asset_list_title_alias ON pcm.pcm_asset_list USING btree (title_alias);


--
