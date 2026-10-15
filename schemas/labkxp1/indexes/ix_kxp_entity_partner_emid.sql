-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_entity_partner_emid
-- Type: INDEX

-- Name: ix_kxp_entity_partner_emid; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_entity_partner_emid ON labkxp1.labkxp_entity_language_map USING btree (entity_master_id);


--
