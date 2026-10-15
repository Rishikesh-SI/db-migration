-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_entity_partner_ermid
-- Type: INDEX

-- Name: ix_swa_entity_partner_ermid; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_entity_partner_ermid ON swa.swa_entity_partner USING btree (entity_role_map_id);


--
