-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_spz_hero_rating_asset_map_hrid; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_hero_rating_asset_map_hrid ON spz.spz_hero_rating_asset_map USING btree (hero_rating_id);


--
