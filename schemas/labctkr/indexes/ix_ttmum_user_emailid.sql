-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labctkr
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labctkr; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labctkr.labctkr_user USING btree (email_id);


--
