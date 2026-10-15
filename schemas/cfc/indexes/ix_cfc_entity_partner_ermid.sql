-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_entity_partner_ermid
-- Type: INDEX

-- Name: ix_cfc_entity_partner_ermid; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_entity_partner_ermid ON cfc.cfc_entity_partner USING btree (entity_role_map_id);


--
