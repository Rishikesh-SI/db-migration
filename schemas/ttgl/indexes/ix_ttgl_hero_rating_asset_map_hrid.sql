-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_ttgl_hero_rating_asset_map_hrid; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_hero_rating_asset_map_hrid ON ttgl.ttgl_hero_rating_asset_map USING btree (hero_rating_id);


--
