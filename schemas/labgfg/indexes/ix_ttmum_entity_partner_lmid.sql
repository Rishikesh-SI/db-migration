-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: ix_ttmum_entity_partner_lmid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_lmid; Type: INDEX; Schema: labgfg; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_lmid ON labgfg.labgfg_entity_language_map USING btree (language_master_id);


--
