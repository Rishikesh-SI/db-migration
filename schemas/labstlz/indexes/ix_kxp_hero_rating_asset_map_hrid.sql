-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_kxp_hero_rating_asset_map_hrid; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_hero_rating_asset_map_hrid ON labstlz.labstlz_hero_rating_asset_map USING btree (hero_rating_id);


--
