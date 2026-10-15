-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_entity_partner_lmid
-- Type: INDEX

-- Name: ix_abp_entity_partner_lmid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_entity_partner_lmid ON abpp.abp_entity_language_map USING btree (language_master_id);


--
