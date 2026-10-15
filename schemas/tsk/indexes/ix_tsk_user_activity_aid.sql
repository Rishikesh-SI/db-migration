-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_user_activity_aid
-- Type: INDEX

-- Name: ix_tsk_user_activity_aid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_user_activity_aid ON tsk.tsk_user_activity USING btree (user_id);


--
