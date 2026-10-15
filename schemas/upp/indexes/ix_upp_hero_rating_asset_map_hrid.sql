-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: ix_upp_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_upp_hero_rating_asset_map_hrid; Type: INDEX; Schema: upp; Owner: -
--

CREATE INDEX ix_upp_hero_rating_asset_map_hrid ON upp.upp_hero_rating_asset_map USING btree (hero_rating_id);


--
