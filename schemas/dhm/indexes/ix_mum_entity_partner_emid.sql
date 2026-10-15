-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_entity_partner_emid
-- Type: INDEX

-- Name: ix_mum_entity_partner_emid; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_entity_partner_emid ON dhm.dhm_entity_language_map USING btree (entity_master_id);


--
