-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_entity_partner_emid
-- Type: INDEX

-- Name: ix_abp_entity_partner_emid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_entity_partner_emid ON abpp.abp_entity_language_map USING btree (entity_master_id);


--
