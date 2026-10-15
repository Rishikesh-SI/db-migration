-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_hero_rating_asset_map_hero_rating_id_idx
-- Type: INDEX

-- Name: lablsg_hero_rating_asset_map_hero_rating_id_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_hero_rating_asset_map_hero_rating_id_idx ON fanxp_lsg.lablsg_hero_rating_asset_map USING btree (hero_rating_id);


--
