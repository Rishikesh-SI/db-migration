-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_user_email
-- Type: INDEX

-- Name: ix_tsk_user_email; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_user_email ON tsk.tsk_user_master USING btree (upper(email_id));


--
