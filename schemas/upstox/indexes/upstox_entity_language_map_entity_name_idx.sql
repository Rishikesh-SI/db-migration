-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_entity_language_map_entity_name_idx
-- Type: INDEX

-- Name: upstox_entity_language_map_entity_name_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE INDEX upstox_entity_language_map_entity_name_idx ON upstox.upstox_entity_language_map USING btree (entity_name);


--
