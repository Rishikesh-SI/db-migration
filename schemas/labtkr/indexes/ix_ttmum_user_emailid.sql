-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labtkr; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labtkr.labtkr_user USING btree (email_id);


--
