-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_entity_partner_ermid
-- Type: INDEX

-- Name: ix_ttgl_entity_partner_ermid; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_entity_partner_ermid ON ttgl.ttgl_entity_partner USING btree (entity_role_map_id);


--
