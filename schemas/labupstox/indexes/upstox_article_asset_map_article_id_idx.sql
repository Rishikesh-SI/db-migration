-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: upstox_article_asset_map_article_id_idx
-- Type: INDEX

-- Name: upstox_article_asset_map_article_id_idx; Type: INDEX; Schema: labupstox; Owner: -
--

CREATE INDEX upstox_article_asset_map_article_id_idx ON labupstox.labupstox_article_asset_map USING btree (article_id);


--
