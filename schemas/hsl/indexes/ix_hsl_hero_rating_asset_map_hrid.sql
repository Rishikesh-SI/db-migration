-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_hsl_hero_rating_asset_map_hrid; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_hero_rating_asset_map_hrid ON hsl.hsl_hero_rating_asset_map USING btree (hero_rating_id);


--
