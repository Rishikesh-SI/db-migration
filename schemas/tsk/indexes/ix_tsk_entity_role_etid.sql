-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_entity_role_etid
-- Type: INDEX

-- Name: ix_tsk_entity_role_etid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_entity_role_etid ON tsk.tsk_entity_role USING btree (entity_type_id);


--
