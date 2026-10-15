-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: ix_ttmum_entity_partner_lmid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_lmid; Type: INDEX; Schema: labkc_v1_02042024; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_lmid ON labkc_v1_02042024.labkc_v1_entity_language_map USING btree (language_master_id);


--
