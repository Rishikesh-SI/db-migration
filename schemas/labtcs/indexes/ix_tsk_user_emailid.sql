-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_user_emailid
-- Type: INDEX

-- Name: ix_tsk_user_emailid; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_user_emailid ON labtcs.labtcs_user USING btree (email_id);


--
