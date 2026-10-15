-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_entity_partner_lmid
-- Type: INDEX

-- Name: ix_upy_entity_partner_lmid; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_entity_partner_lmid ON upy.upy_entity_language_map USING btree (language_master_id);


--
