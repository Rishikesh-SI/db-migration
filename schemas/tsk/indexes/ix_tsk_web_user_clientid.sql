-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_web_user_clientid
-- Type: INDEX

-- Name: ix_tsk_web_user_clientid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_web_user_clientid ON tsk.tsk_web_user USING btree (upper_email_id, client_id);


--
