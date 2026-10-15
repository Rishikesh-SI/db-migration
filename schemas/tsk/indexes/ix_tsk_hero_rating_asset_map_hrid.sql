-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_hero_rating_asset_map_hrid
-- Type: INDEX

-- Name: ix_tsk_hero_rating_asset_map_hrid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_hero_rating_asset_map_hrid ON tsk.tsk_hero_rating_asset_map USING btree (hero_rating_id);


--
