-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: ix_scup_entity_partner_emid
-- Type: INDEX

-- Name: ix_scup_entity_partner_emid; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX ix_scup_entity_partner_emid ON u17wc.u17wc_entity_language_map USING btree (entity_master_id);


--
