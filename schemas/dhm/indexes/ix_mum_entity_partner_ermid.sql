-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_entity_partner_ermid
-- Type: INDEX

-- Name: ix_mum_entity_partner_ermid; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_entity_partner_ermid ON dhm.dhm_entity_partner USING btree (entity_role_map_id);


--
