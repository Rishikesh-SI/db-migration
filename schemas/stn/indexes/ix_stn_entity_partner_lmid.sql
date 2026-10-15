-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_entity_partner_lmid
-- Type: INDEX

-- Name: ix_stn_entity_partner_lmid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_entity_partner_lmid ON stn.stn_entity_language_map USING btree (language_master_id);


--
