-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labw88.labw88_user USING btree (email_id);


--
