-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_entity_partner_lmid
-- Type: INDEX

-- Name: ix_khi_entity_partner_lmid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_entity_partner_lmid ON khi.khi_entity_language_map USING btree (language_master_id);


--
