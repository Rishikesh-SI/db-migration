-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_entity_partner_lmid
-- Type: INDEX

-- Name: ix_ttgl_entity_partner_lmid; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_entity_partner_lmid ON ttgl.ttgl_entity_language_map USING btree (language_master_id);


--
