-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: ix_scup_entity_partner_ermid
-- Type: INDEX

-- Name: ix_scup_entity_partner_ermid; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX ix_scup_entity_partner_ermid ON u17wc.u17wc_entity_partner USING btree (entity_role_map_id);


--
