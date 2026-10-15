-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_entity_master_ename
-- Type: INDEX

-- Name: ix_tsk_entity_master_ename; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_entity_master_ename ON tsk.tsk_entity_master USING btree (entity_name);


--
