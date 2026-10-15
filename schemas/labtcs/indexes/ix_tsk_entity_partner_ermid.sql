-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_entity_partner_ermid
-- Type: INDEX

-- Name: ix_tsk_entity_partner_ermid; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_entity_partner_ermid ON labtcs.labtcs_entity_partner USING btree (entity_role_map_id);


--
