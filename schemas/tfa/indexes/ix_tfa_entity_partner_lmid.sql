-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_entity_partner_lmid
-- Type: INDEX

-- Name: ix_tfa_entity_partner_lmid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_entity_partner_lmid ON tfa.tfa_entity_language_map_newbk USING btree (language_master_id);


--
