-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_entity_partner_ermid
-- Type: INDEX

-- Name: ix_hsl_entity_partner_ermid; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_entity_partner_ermid ON hsl.hsl_entity_partner USING btree (entity_role_map_id);


--
