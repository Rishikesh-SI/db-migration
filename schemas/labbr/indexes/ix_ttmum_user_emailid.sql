-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labbr; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labbr.labbr_user USING btree (email_id);


--
