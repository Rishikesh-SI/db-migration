-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labdsg; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labdsg.labdsg_user USING btree (email_id);


--
