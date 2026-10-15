-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labrr; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labrr.labrr_user USING btree (email_id);


--
