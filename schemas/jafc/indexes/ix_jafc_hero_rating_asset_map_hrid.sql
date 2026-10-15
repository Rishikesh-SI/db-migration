-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_jafc_hero_rating_asset_map_hrid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_hero_rating_asset_map_hrid ON jafc.jafc_hero_rating_asset_map USING btree (hero_rating_id);


--
