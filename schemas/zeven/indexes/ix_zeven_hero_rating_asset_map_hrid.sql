-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_zeven_hero_rating_asset_map_hrid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_hero_rating_asset_map_hrid ON zeven.zeven_hero_rating_asset_map USING btree (hero_rating_id);


--
