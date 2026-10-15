-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: ix_ttmum_entity_partner_lmid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_lmid; Type: INDEX; Schema: labsrk; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_lmid ON labsrk.labsrk_entity_language_map USING btree (language_master_id);


--
