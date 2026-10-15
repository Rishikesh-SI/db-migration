-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp05092024
-- Object: ix_ttmum_entity_partner_lmid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_lmid; Type: INDEX; Schema: labecn_bkp05092024; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_lmid ON labecn_bkp05092024.labecn_entity_language_map USING btree (language_master_id);


--
