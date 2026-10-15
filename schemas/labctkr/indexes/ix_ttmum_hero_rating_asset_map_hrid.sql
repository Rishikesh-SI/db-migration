-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labctkr
-- Object: ix_ttmum_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_asset_map_hrid; Type: INDEX; Schema: labctkr; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_asset_map_hrid ON labctkr.labctkr_hero_rating_asset_map USING btree (hero_rating_id);


--
