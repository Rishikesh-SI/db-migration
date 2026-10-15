-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_entity_partner_entity_role_map_id_idx
-- Type: INDEX

-- Name: upstox_entity_partner_entity_role_map_id_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE INDEX upstox_entity_partner_entity_role_map_id_idx ON upstox.upstox_entity_partner USING btree (entity_role_map_id);


--
