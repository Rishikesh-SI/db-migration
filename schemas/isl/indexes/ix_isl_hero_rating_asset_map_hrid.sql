-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_isl_hero_rating_asset_map_hrid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_hero_rating_asset_map_hrid ON isl.isl_hero_rating_asset_map USING btree (hero_rating_id);


--
