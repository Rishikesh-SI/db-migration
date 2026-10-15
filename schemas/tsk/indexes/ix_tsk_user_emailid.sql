-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_user_emailid
-- Type: INDEX

-- Name: ix_tsk_user_emailid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_user_emailid ON tsk.tsk_user USING btree (email_id);


--
