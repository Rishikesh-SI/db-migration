-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkrold
-- Object: ix_ttmum_entity_partner_ermid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_ermid; Type: INDEX; Schema: labtkrold; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_ermid ON labtkrold.labtkr_entity_partner USING btree (entity_role_map_id);


--
