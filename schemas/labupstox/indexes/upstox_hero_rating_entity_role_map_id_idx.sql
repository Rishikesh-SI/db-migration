-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: upstox_hero_rating_entity_role_map_id_idx
-- Type: INDEX

-- Name: upstox_hero_rating_entity_role_map_id_idx; Type: INDEX; Schema: labupstox; Owner: -
--

CREATE INDEX upstox_hero_rating_entity_role_map_id_idx ON labupstox.labupstox_hero_rating USING btree (entity_role_map_id);


--
