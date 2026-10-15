-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_hero_rating_asset_map_hero_rating_id_idx
-- Type: INDEX

-- Name: labwf_hero_rating_asset_map_hero_rating_id_idx; Type: INDEX; Schema: fanxp_wf; Owner: -
--

CREATE INDEX labwf_hero_rating_asset_map_hero_rating_id_idx ON fanxp_wf.labwf_hero_rating_asset_map USING btree (hero_rating_id);


--
