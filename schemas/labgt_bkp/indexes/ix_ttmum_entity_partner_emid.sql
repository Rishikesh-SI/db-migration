-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: ix_ttmum_entity_partner_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_emid; Type: INDEX; Schema: labgt_bkp; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_emid ON labgt_bkp.labgt_entity_language_map USING btree (entity_master_id);


--
