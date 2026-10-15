-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: ix_ttmum_entity_partner_lmid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_lmid; Type: INDEX; Schema: labkkr_v1; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_lmid ON labkkr_v1.labkkr_v1_entity_language_map USING btree (language_master_id);


--
