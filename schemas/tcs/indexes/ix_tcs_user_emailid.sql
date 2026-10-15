-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_user_emailid
-- Type: INDEX

-- Name: ix_tcs_user_emailid; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_user_emailid ON tcs.tcs_user USING btree (email_id);


--
