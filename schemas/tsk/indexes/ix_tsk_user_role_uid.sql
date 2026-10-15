-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_user_role_uid
-- Type: INDEX

-- Name: ix_tsk_user_role_uid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_user_role_uid ON tsk.tsk_user_role USING btree (user_id);


--
