-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_entity_partner_entity_role_map_id_idx
-- Type: INDEX

-- Name: lablsg_entity_partner_entity_role_map_id_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_entity_partner_entity_role_map_id_idx ON fanxp_lsg.lablsg_entity_partner USING btree (entity_role_map_id);


--
