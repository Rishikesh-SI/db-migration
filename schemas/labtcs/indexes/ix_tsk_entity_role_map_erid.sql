-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_entity_role_map_erid
-- Type: INDEX

-- Name: ix_tsk_entity_role_map_erid; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_entity_role_map_erid ON labtcs.labtcs_entity_role_map USING btree (entity_role_id);


--
