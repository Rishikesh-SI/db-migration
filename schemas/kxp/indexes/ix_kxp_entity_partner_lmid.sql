-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_entity_partner_lmid
-- Type: INDEX

-- Name: ix_kxp_entity_partner_lmid; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_entity_partner_lmid ON kxp.kxp_entity_language_map USING btree (language_master_id);


--
