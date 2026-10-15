-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: ix_upp_entity_partner_lmid
-- Type: INDEX

-- Name: ix_upp_entity_partner_lmid; Type: INDEX; Schema: upp; Owner: -
--

CREATE INDEX ix_upp_entity_partner_lmid ON upp.upp_entity_language_map USING btree (language_master_id);


--
