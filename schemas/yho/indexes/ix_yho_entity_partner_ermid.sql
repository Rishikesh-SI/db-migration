-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_entity_partner_ermid
-- Type: INDEX

-- Name: ix_yho_entity_partner_ermid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_entity_partner_ermid ON yho.yho_entity_partner USING btree (entity_role_map_id);


--
