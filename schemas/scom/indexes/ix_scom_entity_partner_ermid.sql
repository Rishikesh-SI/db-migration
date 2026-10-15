-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_entity_partner_ermid
-- Type: INDEX

-- Name: ix_scom_entity_partner_ermid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_entity_partner_ermid ON scom.scom_entity_partner USING btree (entity_role_map_id);


--
