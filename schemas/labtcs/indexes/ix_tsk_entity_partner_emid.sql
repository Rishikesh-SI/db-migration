-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_entity_partner_emid
-- Type: INDEX

-- Name: ix_tsk_entity_partner_emid; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_entity_partner_emid ON labtcs.labtcs_entity_language_map USING btree (entity_master_id);


--
