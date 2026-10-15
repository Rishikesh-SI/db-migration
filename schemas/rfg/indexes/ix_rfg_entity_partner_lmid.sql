-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_entity_partner_lmid
-- Type: INDEX

-- Name: ix_rfg_entity_partner_lmid; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_entity_partner_lmid ON rfg.rfg_entity_language_map USING btree (language_master_id);


--
