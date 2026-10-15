-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: upstox_asset_list_title_alias_idx
-- Type: INDEX

-- Name: upstox_asset_list_title_alias_idx; Type: INDEX; Schema: labupstox; Owner: -
--

CREATE INDEX upstox_asset_list_title_alias_idx ON labupstox.labupstox_asset_list USING btree (title_alias);


--
