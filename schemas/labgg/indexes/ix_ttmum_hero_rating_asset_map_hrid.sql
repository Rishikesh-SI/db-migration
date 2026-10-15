-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: ix_ttmum_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_asset_map_hrid; Type: INDEX; Schema: labgg; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_asset_map_hrid ON labgg.labgg_hero_rating_asset_map USING btree (hero_rating_id);


--
