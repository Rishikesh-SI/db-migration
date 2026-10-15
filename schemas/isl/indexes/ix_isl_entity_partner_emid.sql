-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_entity_partner_emid
-- Type: INDEX

-- Name: ix_isl_entity_partner_emid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_entity_partner_emid ON isl.isl_entity_language_map USING btree (entity_master_id);


--
