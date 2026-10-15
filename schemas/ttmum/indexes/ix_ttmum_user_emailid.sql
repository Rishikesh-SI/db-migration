-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: ttmum; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON ttmum.ttmum_user USING btree (email_id);


--
