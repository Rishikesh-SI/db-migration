-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: ix_pkl_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_pkl_hero_rating_asset_map_hrid; Type: INDEX; Schema: labpkl_v1; Owner: -
--

CREATE INDEX ix_pkl_hero_rating_asset_map_hrid ON labpkl_v1.labpkl_v1_hero_rating_asset_map USING btree (hero_rating_id);


--
