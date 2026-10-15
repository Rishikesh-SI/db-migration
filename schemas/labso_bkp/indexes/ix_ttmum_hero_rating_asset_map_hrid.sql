-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labso_bkp
-- Object: ix_ttmum_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_asset_map_hrid; Type: INDEX; Schema: labso_bkp; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_asset_map_hrid ON labso_bkp.labso_hero_rating_asset_map USING btree (hero_rating_id);


--
