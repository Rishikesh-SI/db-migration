-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_web_user_clientidsocid
-- Type: INDEX

-- Name: ix_tsk_web_user_clientidsocid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_web_user_clientidsocid ON tsk.tsk_web_user USING btree (social_id, client_id) WHERE (social_id IS NOT NULL);


--
