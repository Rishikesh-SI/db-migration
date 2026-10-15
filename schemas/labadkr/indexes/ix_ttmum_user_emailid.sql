-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labadkr; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labadkr.labadkr_user USING btree (email_id);


--
