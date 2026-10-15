-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_swa_hero_rating_asset_map_hrid; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_hero_rating_asset_map_hrid ON swa.swa_hero_rating_asset_map USING btree (hero_rating_id);


--
