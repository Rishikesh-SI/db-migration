-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labetpl; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labetpl.labetpl_user USING btree (email_id);


--
