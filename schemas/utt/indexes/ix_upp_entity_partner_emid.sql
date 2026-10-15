-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: ix_upp_entity_partner_emid
-- Type: INDEX

-- Name: ix_upp_entity_partner_emid; Type: INDEX; Schema: utt; Owner: -
--

CREATE INDEX ix_upp_entity_partner_emid ON utt.utt_entity_language_map USING btree (entity_master_id);


--
