-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: ix_ttmum_entity_partner_ermid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_ermid; Type: INDEX; Schema: lablsg_v1; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_ermid ON lablsg_v1.lablsg_v1_entity_partner USING btree (entity_role_map_id);


--
