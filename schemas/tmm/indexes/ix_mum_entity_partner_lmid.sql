-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_entity_partner_lmid
-- Type: INDEX

-- Name: ix_mum_entity_partner_lmid; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_entity_partner_lmid ON tmm.tmm_entity_language_map USING btree (language_master_id);


--
