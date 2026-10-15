-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_entity_partner_lmid
-- Type: INDEX

-- Name: ix_mum_entity_partner_lmid; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_entity_partner_lmid ON tmmimg_upd.tmmimg_upd_entity_language_map USING btree (language_master_id);


--
