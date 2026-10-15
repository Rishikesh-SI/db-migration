-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: ix_upp_user_emailid
-- Type: INDEX

-- Name: ix_upp_user_emailid; Type: INDEX; Schema: utt; Owner: -
--

CREATE INDEX ix_upp_user_emailid ON utt.utt_user USING btree (email_id);


--
