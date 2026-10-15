-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labrs; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labrs.labrs_user USING btree (email_id);


--
