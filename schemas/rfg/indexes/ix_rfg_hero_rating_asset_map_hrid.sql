-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_rfg_hero_rating_asset_map_hrid; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_hero_rating_asset_map_hrid ON rfg.rfg_hero_rating_asset_map USING btree (hero_rating_id);


--
