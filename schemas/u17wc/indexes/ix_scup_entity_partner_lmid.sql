-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: ix_scup_entity_partner_lmid
-- Type: INDEX

-- Name: ix_scup_entity_partner_lmid; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX ix_scup_entity_partner_lmid ON u17wc.u17wc_entity_language_map USING btree (language_master_id);


--
