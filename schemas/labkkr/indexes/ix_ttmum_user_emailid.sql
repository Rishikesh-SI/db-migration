-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labkkr; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labkkr.labkkr_user USING btree (email_id);


--
