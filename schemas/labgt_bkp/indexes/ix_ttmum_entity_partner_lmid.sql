-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: ix_ttmum_entity_partner_lmid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_lmid; Type: INDEX; Schema: labgt_bkp; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_lmid ON labgt_bkp.labgt_entity_language_map USING btree (language_master_id);


--
