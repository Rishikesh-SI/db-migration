-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_entity_partner_emid
-- Type: INDEX

-- Name: ix_swa_entity_partner_emid; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_entity_partner_emid ON swa.swa_entity_language_map_newbk USING btree (entity_master_id);


--
