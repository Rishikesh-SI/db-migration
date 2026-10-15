-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: ix_kxp_entity_partner_emid
-- Type: INDEX

-- Name: ix_kxp_entity_partner_emid; Type: INDEX; Schema: labkxp; Owner: -
--

CREATE INDEX ix_kxp_entity_partner_emid ON labkxp.labkxp_entity_language_map USING btree (entity_master_id);


--
