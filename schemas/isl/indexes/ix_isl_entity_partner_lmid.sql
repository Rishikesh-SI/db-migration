-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_entity_partner_lmid
-- Type: INDEX

-- Name: ix_isl_entity_partner_lmid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_entity_partner_lmid ON isl.isl_entity_language_map USING btree (language_master_id);


--
