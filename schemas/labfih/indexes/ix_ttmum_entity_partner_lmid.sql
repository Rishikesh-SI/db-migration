-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: ix_ttmum_entity_partner_lmid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_lmid; Type: INDEX; Schema: labfih; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_lmid ON labfih.labfih_entity_language_map USING btree (language_master_id);


--
