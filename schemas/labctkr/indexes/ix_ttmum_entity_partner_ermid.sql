-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labctkr
-- Object: ix_ttmum_entity_partner_ermid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_ermid; Type: INDEX; Schema: labctkr; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_ermid ON labctkr.labctkr_entity_partner USING btree (entity_role_map_id);


--
