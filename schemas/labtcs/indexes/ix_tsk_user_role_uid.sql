-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_user_role_uid
-- Type: INDEX

-- Name: ix_tsk_user_role_uid; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_user_role_uid ON labtcs.labtcs_user_role USING btree (user_id);


--
