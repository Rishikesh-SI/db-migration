-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labeisl
-- Object: ix_ttmum_entity_partner_ermid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_ermid; Type: INDEX; Schema: labeisl; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_ermid ON labeisl.labeisl_entity_partner USING btree (entity_role_map_id);


--
