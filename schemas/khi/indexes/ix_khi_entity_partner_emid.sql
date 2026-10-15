-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_entity_partner_emid
-- Type: INDEX

-- Name: ix_khi_entity_partner_emid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_entity_partner_emid ON khi.khi_entity_language_map USING btree (entity_master_id);


--
