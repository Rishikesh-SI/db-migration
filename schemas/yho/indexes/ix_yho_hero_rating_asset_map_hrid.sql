-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_yho_hero_rating_asset_map_hrid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_hero_rating_asset_map_hrid ON yho.yho_hero_rating_asset_map USING btree (hero_rating_id);


--
