-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_entity_partner_emid
-- Type: INDEX

-- Name: ix_tfa_entity_partner_emid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_entity_partner_emid ON tfa.tfa_entity_language_map_newbk USING btree (entity_master_id);


--
