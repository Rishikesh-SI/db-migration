-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labfih; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labfih.labfih_user USING btree (email_id);


--
