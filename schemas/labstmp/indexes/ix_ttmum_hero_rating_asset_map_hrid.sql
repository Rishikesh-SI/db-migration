-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: ix_ttmum_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_asset_map_hrid; Type: INDEX; Schema: labstmp; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_asset_map_hrid ON labstmp.labstmp_hero_rating_asset_map USING btree (hero_rating_id);


--
