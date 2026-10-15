-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labeisl
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labeisl; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labeisl.labeisl_user USING btree (email_id);


--
