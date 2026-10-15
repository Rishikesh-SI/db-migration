-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_scom_hero_rating_asset_map_hrid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_hero_rating_asset_map_hrid ON scom.scom_hero_rating_asset_map USING btree (hero_rating_id);


--
