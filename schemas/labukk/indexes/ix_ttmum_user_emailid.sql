-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labukk
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labukk; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labukk.labukk_user USING btree (email_id);


--
