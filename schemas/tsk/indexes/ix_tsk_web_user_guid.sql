-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_web_user_guid
-- Type: INDEX

-- Name: ix_tsk_web_user_guid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE UNIQUE INDEX ix_tsk_web_user_guid ON tsk.tsk_web_user USING btree (user_guid);


--
