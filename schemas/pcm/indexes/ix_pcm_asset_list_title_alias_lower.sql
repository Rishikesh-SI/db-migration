-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_asset_list_title_alias_lower
-- Type: INDEX

-- Name: ix_pcm_asset_list_title_alias_lower; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_asset_list_title_alias_lower ON pcm.pcm_asset_list USING btree (lower((title_alias)::text));


--
