-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: ix_ttmum_entity_partner_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_emid; Type: INDEX; Schema: labfg; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_emid ON labfg.labfg_entity_language_map USING btree (entity_master_id);


--
