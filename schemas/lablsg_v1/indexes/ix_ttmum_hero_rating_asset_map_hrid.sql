-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: ix_ttmum_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_asset_map_hrid; Type: INDEX; Schema: lablsg_v1; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_asset_map_hrid ON lablsg_v1.lablsg_v1_hero_rating_asset_map USING btree (hero_rating_id);


--
