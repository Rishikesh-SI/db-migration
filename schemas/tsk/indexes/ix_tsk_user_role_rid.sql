-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_user_role_rid
-- Type: INDEX

-- Name: ix_tsk_user_role_rid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_user_role_rid ON tsk.tsk_user_role USING btree (role_id);


--
