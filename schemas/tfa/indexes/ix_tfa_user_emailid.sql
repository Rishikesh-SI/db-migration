-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_user_emailid
-- Type: INDEX

-- Name: ix_tfa_user_emailid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_user_emailid ON tfa.tfa_user USING btree (email_id);


--
