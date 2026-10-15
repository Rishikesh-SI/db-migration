-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: ix_ttmum_entity_partner_ermid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_ermid; Type: INDEX; Schema: labgfg; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_ermid ON labgfg.labgfg_entity_partner USING btree (entity_role_map_id);


--
