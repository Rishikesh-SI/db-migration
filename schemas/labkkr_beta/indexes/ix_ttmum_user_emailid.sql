-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_beta
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labkkr_beta; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labkkr_beta.labkkr_user USING btree (email_id);


--
