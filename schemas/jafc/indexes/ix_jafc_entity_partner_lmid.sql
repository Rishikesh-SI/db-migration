-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_entity_partner_lmid
-- Type: INDEX

-- Name: ix_jafc_entity_partner_lmid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_entity_partner_lmid ON jafc.jafc_entity_language_map USING btree (language_master_id);


--
