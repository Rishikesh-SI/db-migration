-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_entity_partner_lmid
-- Type: INDEX

-- Name: ix_yho_entity_partner_lmid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_entity_partner_lmid ON yho.yho_entity_language_map USING btree (language_master_id);


--
