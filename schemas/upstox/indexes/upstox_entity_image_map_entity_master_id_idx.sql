-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_entity_image_map_entity_master_id_idx
-- Type: INDEX

-- Name: upstox_entity_image_map_entity_master_id_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE INDEX upstox_entity_image_map_entity_master_id_idx ON upstox.upstox_entity_image_map USING btree (entity_master_id);


--
