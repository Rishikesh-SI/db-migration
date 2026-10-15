-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labukk
-- Object: ix_ttmum_entity_partner_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_emid; Type: INDEX; Schema: labukk; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_emid ON labukk.labukk_entity_language_map USING btree (entity_master_id);


--
