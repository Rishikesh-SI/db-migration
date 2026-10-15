-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_mum_hero_rating_asset_map_hrid; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_hero_rating_asset_map_hrid ON tmmimg_upd.tmmimg_upd_hero_rating_asset_map USING btree (hero_rating_id);


--
