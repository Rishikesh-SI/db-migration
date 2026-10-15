-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: ix_ttmum_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_asset_map_hrid; Type: INDEX; Schema: labbr; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_asset_map_hrid ON labbr.labbr_hero_rating_asset_map USING btree (hero_rating_id);


--
