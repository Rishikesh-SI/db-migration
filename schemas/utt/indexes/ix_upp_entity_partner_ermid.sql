-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: ix_upp_entity_partner_ermid
-- Type: INDEX

-- Name: ix_upp_entity_partner_ermid; Type: INDEX; Schema: utt; Owner: -
--

CREATE INDEX ix_upp_entity_partner_ermid ON utt.utt_entity_partner USING btree (entity_role_map_id);


--
