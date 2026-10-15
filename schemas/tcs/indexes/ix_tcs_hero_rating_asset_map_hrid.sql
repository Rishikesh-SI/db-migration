-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_tcs_hero_rating_asset_map_hrid; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_hero_rating_asset_map_hrid ON tcs.tcs_hero_rating_asset_map USING btree (hero_rating_id);


--
