-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labmi; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labmi.labmi_user USING btree (email_id);


--
