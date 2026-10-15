-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_ppb_hero_rating_asset_map_hrid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_hero_rating_asset_map_hrid ON ppb.ppb_hero_rating_asset_map USING btree (hero_rating_id);


--
