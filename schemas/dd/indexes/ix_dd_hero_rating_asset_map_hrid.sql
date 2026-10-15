-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_dd_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_dd_hero_rating_asset_map_hrid; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_dd_hero_rating_asset_map_hrid ON dd.dd_hero_rating_asset_map USING btree (hero_rating_id);


--
