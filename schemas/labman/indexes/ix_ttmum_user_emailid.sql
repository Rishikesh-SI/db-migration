-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labman; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labman.labman_user USING btree (email_id);


--
