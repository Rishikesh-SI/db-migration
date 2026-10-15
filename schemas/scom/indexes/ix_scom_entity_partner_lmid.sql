-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_entity_partner_lmid
-- Type: INDEX

-- Name: ix_scom_entity_partner_lmid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_entity_partner_lmid ON scom.scom_entity_language_map USING btree (language_master_id);


--
