-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_entity_partner_lmid
-- Type: INDEX

-- Name: ix_gsf_entity_partner_lmid; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_entity_partner_lmid ON gsf.gsf_entity_language_map USING btree (language_master_id);


--
