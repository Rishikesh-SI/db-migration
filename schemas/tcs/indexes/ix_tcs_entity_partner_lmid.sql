-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_entity_partner_lmid
-- Type: INDEX

-- Name: ix_tcs_entity_partner_lmid; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_entity_partner_lmid ON tcs.tcs_entity_language_map USING btree (language_master_id);


--
