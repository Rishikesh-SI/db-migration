-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: ix_ttmum_entity_partner_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_emid; Type: INDEX; Schema: labhkind; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_emid ON labhkind.labhkind_entity_language_map USING btree (entity_master_id);


--
