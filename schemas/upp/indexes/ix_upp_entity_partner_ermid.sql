-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: ix_upp_entity_partner_ermid
-- Type: INDEX

-- Name: ix_upp_entity_partner_ermid; Type: INDEX; Schema: upp; Owner: -
--

CREATE INDEX ix_upp_entity_partner_ermid ON upp.upp_entity_partner USING btree (entity_role_map_id);


--
