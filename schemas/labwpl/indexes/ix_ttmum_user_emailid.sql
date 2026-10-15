-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labwpl; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labwpl.labwpl_user USING btree (email_id);


--
