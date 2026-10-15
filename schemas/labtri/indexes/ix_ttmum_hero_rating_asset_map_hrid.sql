-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: ix_ttmum_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_asset_map_hrid; Type: INDEX; Schema: labtri; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_asset_map_hrid ON labtri.labtri_hero_rating_asset_map USING btree (hero_rating_id);


--
