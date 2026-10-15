-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_khi_hero_rating_asset_map_hrid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_hero_rating_asset_map_hrid ON khi.khi_hero_rating_asset_map USING btree (hero_rating_id);


--
