-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_entity_partner_emid
-- Type: INDEX

-- Name: ix_hsl_entity_partner_emid; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_entity_partner_emid ON labhsl.labhsl_entity_language_map USING btree (entity_master_id);


--
