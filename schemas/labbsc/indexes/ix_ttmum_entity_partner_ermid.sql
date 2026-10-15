-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: ix_ttmum_entity_partner_ermid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_ermid; Type: INDEX; Schema: labbsc; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_ermid ON labbsc.labbsc_entity_partner USING btree (entity_role_map_id);


--
