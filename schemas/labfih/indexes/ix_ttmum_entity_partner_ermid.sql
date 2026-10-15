-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: ix_ttmum_entity_partner_ermid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_ermid; Type: INDEX; Schema: labfih; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_ermid ON labfih.labfih_entity_partner USING btree (entity_role_map_id);


--
