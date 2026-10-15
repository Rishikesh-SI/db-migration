-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiyg
-- Object: ix_ttmum_entity_partner_ermid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_ermid; Type: INDEX; Schema: labkiyg; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_ermid ON labkiyg.labkiyg_entity_partner USING btree (entity_role_map_id);


--
