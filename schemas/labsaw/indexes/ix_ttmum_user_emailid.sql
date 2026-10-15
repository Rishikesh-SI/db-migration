-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labsaw; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labsaw.labsaw_user USING btree (email_id);


--
