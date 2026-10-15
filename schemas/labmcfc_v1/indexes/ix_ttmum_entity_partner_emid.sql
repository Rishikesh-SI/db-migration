-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc_v1
-- Object: ix_ttmum_entity_partner_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_partner_emid; Type: INDEX; Schema: labmcfc_v1; Owner: -
--

CREATE INDEX ix_ttmum_entity_partner_emid ON labmcfc_v1.labmcfc_v1_entity_language_map USING btree (entity_master_id);


--
