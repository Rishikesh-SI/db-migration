-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_article_asset_map_article_id_idx
-- Type: INDEX

-- Name: upstox_article_asset_map_article_id_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE INDEX upstox_article_asset_map_article_id_idx ON upstox.upstox_article_asset_map USING btree (article_id);


--
