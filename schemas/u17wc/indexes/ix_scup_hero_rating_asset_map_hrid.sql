-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: ix_scup_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_scup_hero_rating_asset_map_hrid; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX ix_scup_hero_rating_asset_map_hrid ON u17wc.u17wc_hero_rating_asset_map USING btree (hero_rating_id);


--
