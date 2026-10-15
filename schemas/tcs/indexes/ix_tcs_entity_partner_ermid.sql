-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_entity_partner_ermid
-- Type: INDEX

-- Name: ix_tcs_entity_partner_ermid; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_entity_partner_ermid ON tcs.tcs_entity_partner USING btree (entity_role_map_id);


--
