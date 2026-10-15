-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwskl
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labwskl; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labwskl.labwskl_user USING btree (email_id);


--
