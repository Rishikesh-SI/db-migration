-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_pbl_hero_rating_asset_map_hrid; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_hero_rating_asset_map_hrid ON pbl.pbl_hero_rating_asset_map USING btree (hero_rating_id);


--
