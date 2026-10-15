-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp03092024
-- Object: ix_ttmum_entity_partner_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_emid; Type: INDEX; Schema: labecn_bkp03092024; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_emid ON labecn_bkp03092024.labecn_entity_language_map USING btree (entity_master_id);


--
