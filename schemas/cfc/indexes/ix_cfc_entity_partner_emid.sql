-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_entity_partner_emid
-- Type: INDEX

-- Name: ix_cfc_entity_partner_emid; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_entity_partner_emid ON cfc.cfc_entity_language_map USING btree (entity_master_id);


--
