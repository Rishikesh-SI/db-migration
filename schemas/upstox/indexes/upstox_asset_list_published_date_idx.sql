-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_asset_list_published_date_idx
-- Type: INDEX

-- Name: upstox_asset_list_published_date_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE INDEX upstox_asset_list_published_date_idx ON upstox.upstox_asset_list USING btree (published_date);


--
