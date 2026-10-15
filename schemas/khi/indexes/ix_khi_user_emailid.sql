-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_user_emailid
-- Type: INDEX

-- Name: ix_khi_user_emailid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_user_emailid ON khi.khi_user USING btree (email_id);


--
