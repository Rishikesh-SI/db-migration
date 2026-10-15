-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_entity_partner_ermid
-- Type: INDEX

-- Name: ix_stn_entity_partner_ermid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_entity_partner_ermid ON stn.stn_entity_partner USING btree (entity_role_map_id);


--
