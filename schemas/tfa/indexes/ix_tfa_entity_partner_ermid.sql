-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_entity_partner_ermid
-- Type: INDEX

-- Name: ix_tfa_entity_partner_ermid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_entity_partner_ermid ON tfa.tfa_entity_partner USING btree (entity_role_map_id);


--
