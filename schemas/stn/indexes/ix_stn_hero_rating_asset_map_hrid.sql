-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_stn_hero_rating_asset_map_hrid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_hero_rating_asset_map_hrid ON stn.stn_hero_rating_asset_map USING btree (hero_rating_id);


--
