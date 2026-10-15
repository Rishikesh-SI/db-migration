-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: upstox_asset_list_published_date_idx
-- Type: INDEX

-- Name: upstox_asset_list_published_date_idx; Type: INDEX; Schema: labupstox; Owner: -
--

CREATE INDEX upstox_asset_list_published_date_idx ON labupstox.labupstox_asset_list USING btree (published_date);


--
