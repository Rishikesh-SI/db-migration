-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labpvl; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labpvl.labpvl_user USING btree (email_id);


--
