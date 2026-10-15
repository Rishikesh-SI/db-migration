-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_cfc_hero_rating_asset_map_hrid; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_hero_rating_asset_map_hrid ON cfc.cfc_hero_rating_asset_map USING btree (hero_rating_id);


--
