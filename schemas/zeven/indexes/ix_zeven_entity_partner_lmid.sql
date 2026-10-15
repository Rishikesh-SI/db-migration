-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_entity_partner_lmid
-- Type: INDEX

-- Name: ix_zeven_entity_partner_lmid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_entity_partner_lmid ON zeven.zeven_entity_language_map USING btree (language_master_id);


--
