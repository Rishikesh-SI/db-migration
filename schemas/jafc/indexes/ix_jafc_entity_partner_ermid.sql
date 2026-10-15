-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_entity_partner_ermid
-- Type: INDEX

-- Name: ix_jafc_entity_partner_ermid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_entity_partner_ermid ON jafc.jafc_entity_partner USING btree (entity_role_map_id);


--
