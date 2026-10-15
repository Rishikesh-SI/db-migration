-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_gsf_hero_rating_asset_map_hrid; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_hero_rating_asset_map_hrid ON gsf.gsf_hero_rating_asset_map USING btree (hero_rating_id);


--
