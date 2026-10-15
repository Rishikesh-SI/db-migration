-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_entity_partner_ermid
-- Type: INDEX

-- Name: ix_ppb_entity_partner_ermid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_entity_partner_ermid ON ppb.ppb_entity_partner USING btree (entity_role_map_id);


--
