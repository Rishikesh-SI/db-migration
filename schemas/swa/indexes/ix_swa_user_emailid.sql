-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_user_emailid
-- Type: INDEX

-- Name: ix_swa_user_emailid; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_user_emailid ON swa.swa_user USING btree (email_id);


--
