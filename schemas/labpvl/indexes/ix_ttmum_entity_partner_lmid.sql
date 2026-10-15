-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: ix_ttmum_entity_partner_lmid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_lmid; Type: INDEX; Schema: labpvl; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_lmid ON labpvl.labpvl_entity_language_map USING btree (language_master_id);


--
