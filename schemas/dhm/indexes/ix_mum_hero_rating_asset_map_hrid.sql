-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_mum_hero_rating_asset_map_hrid; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_hero_rating_asset_map_hrid ON dhm.dhm_hero_rating_asset_map USING btree (hero_rating_id);


--
