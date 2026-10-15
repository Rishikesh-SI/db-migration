-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: ix_ttmum_entity_partner_lmid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_lmid; Type: INDEX; Schema: labuww; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_lmid ON labuww.labuww_entity_language_map USING btree (language_master_id);


--
