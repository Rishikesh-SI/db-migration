-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labecn; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labecn.labecn_user USING btree (email_id);


--
