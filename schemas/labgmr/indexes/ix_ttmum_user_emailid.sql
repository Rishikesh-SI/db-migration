-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labgmr; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labgmr.labgmr_user USING btree (email_id);


--
