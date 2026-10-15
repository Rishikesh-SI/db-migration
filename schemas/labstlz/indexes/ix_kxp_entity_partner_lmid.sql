-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_entity_partner_lmid
-- Type: INDEX

-- Name: ix_kxp_entity_partner_lmid; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_entity_partner_lmid ON labstlz.labstlz_entity_language_map USING btree (language_master_id);


--
