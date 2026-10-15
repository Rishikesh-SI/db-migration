-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_ttmum_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_asset_map_hrid; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_asset_map_hrid ON labw88.labw88_hero_rating_asset_map USING btree (hero_rating_id);


--
