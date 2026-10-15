-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1_bkp_29012025
-- Object: ix_ttmum_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_asset_map_hrid; Type: INDEX; Schema: labecn_v1_bkp_29012025; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_asset_map_hrid ON labecn_v1_bkp_29012025.labecn_v1_hero_rating_asset_map USING btree (hero_rating_id);


--
