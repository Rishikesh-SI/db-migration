-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: ix_ttmum_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_asset_map_hrid; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_asset_map_hrid ON labgt.labgt_hero_rating_asset_map USING btree (hero_rating_id);


--
