-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_entity_role_map_emid
-- Type: INDEX

-- Name: ix_tsk_entity_role_map_emid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_entity_role_map_emid ON tsk.tsk_entity_role_map USING btree (entity_master_id);


--
