-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_entity_partner_ermid
-- Type: INDEX

-- Name: ix_isl_entity_partner_ermid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_entity_partner_ermid ON isl.isl_entity_partner USING btree (entity_role_map_id);


--
