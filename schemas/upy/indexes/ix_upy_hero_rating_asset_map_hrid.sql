-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_upy_hero_rating_asset_map_hrid; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_hero_rating_asset_map_hrid ON upy.upy_hero_rating_asset_map USING btree (hero_rating_id);


--
