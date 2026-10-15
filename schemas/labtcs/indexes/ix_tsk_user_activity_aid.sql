-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_user_activity_aid
-- Type: INDEX

-- Name: ix_tsk_user_activity_aid; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_user_activity_aid ON labtcs.labtcs_user_activity USING btree (user_id);


--
