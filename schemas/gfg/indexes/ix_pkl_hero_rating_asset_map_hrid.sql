-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: ix_pkl_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_pkl_hero_rating_asset_map_hrid; Type: INDEX; Schema: gfg; Owner: -
--

CREATE INDEX ix_pkl_hero_rating_asset_map_hrid ON gfg.gfg_hero_rating_asset_map USING btree (hero_rating_id);


--
