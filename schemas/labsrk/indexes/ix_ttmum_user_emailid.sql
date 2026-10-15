-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labsrk; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labsrk.labsrk_user USING btree (email_id);


--
