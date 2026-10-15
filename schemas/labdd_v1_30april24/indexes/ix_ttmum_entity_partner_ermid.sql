-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1_30april24
-- Object: ix_ttmum_entity_partner_ermid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_ermid; Type: INDEX; Schema: labdd_v1_30april24; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_ermid ON labdd_v1_30april24.labdd_v1_entity_partner USING btree (entity_role_map_id);


--
