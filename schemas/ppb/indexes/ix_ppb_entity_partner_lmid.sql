-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_entity_partner_lmid
-- Type: INDEX

-- Name: ix_ppb_entity_partner_lmid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_entity_partner_lmid ON ppb.ppb_entity_language_map USING btree (language_master_id);


--
