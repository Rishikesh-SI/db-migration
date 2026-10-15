-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr_beta
-- Object: ix_ttmum_entity_partner_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_emid; Type: INDEX; Schema: labtkr_beta; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_emid ON labtkr_beta.labtkr_entity_language_map USING btree (entity_master_id);


--
