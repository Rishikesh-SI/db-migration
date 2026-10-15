-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiyg
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labkiyg; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labkiyg.labkiyg_user USING btree (email_id);


--
