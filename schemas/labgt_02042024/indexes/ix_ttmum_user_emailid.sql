-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labgt_02042024; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labgt_02042024.labgt_user USING btree (email_id);


--
