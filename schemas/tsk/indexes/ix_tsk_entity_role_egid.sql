-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_entity_role_egid
-- Type: INDEX

-- Name: ix_tsk_entity_role_egid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_entity_role_egid ON tsk.tsk_entity_role USING btree (entity_group_id);


--
