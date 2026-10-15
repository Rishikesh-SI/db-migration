-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labkc; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labkc.labkc_user USING btree (email_id);


--
