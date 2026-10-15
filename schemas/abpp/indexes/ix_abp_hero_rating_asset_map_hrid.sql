-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_abp_hero_rating_asset_map_hrid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_hero_rating_asset_map_hrid ON abpp.abp_hero_rating_asset_map USING btree (hero_rating_id);


--
