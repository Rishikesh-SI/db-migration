-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: ix_upp_entity_partner_lmid
-- Type: INDEX

-- Name: ix_upp_entity_partner_lmid; Type: INDEX; Schema: utt; Owner: -
--

CREATE INDEX ix_upp_entity_partner_lmid ON utt.utt_entity_language_map USING btree (language_master_id);


--
