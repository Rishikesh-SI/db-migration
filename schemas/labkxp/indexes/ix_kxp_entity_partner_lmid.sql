-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: ix_kxp_entity_partner_lmid
-- Type: INDEX

-- Name: ix_kxp_entity_partner_lmid; Type: INDEX; Schema: labkxp; Owner: -
--

CREATE INDEX ix_kxp_entity_partner_lmid ON labkxp.labkxp_entity_language_map USING btree (language_master_id);


--
