-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkrold
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labtkrold; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labtkrold.labtkr_user USING btree (email_id);


--
