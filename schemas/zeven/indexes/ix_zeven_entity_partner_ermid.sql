-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_entity_partner_ermid
-- Type: INDEX

-- Name: ix_zeven_entity_partner_ermid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_entity_partner_ermid ON zeven.zeven_entity_partner USING btree (entity_role_map_id);


--
