-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: ix_upp_user_emailid
-- Type: INDEX

-- Name: ix_upp_user_emailid; Type: INDEX; Schema: upp; Owner: -
--

CREATE INDEX ix_upp_user_emailid ON upp.upp_user USING btree (email_id);


--
