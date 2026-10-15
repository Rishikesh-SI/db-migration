-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labets; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labets.labets_user USING btree (email_id);


--
