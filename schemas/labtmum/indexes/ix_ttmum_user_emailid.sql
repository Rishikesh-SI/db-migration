-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtmum
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labtmum; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labtmum.labtmum_user USING btree (email_id);


--
