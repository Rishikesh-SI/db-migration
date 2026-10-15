-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: ix_ttmum_entity_partner_lmid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_lmid; Type: INDEX; Schema: labal_nassr; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_lmid ON labal_nassr.labal_nassr_entity_language_map USING btree (language_master_id);


--
