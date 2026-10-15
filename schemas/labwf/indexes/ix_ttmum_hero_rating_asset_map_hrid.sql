-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: ix_ttmum_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_asset_map_hrid; Type: INDEX; Schema: labwf; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_asset_map_hrid ON labwf.labwf_hero_rating_asset_map USING btree (hero_rating_id);


--
