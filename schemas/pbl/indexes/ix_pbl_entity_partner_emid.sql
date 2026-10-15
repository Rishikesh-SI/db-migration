-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_entity_partner_emid
-- Type: INDEX

-- Name: ix_pbl_entity_partner_emid; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_entity_partner_emid ON pbl.pbl_entity_language_map USING btree (entity_master_id);


--
