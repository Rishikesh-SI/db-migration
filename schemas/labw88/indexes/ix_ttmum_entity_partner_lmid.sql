-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_ttmum_entity_partner_lmid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_lmid; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_lmid ON labw88.labw88_entity_language_map USING btree (language_master_id);


--
