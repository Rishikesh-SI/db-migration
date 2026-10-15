-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: ix_ttmum_entity_partner_lmid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_lmid; Type: INDEX; Schema: labstrd; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_lmid ON labstrd.labstrd_entity_language_map USING btree (language_master_id);


--
