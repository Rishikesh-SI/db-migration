-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labrao; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labrao.labrao_user USING btree (email_id);


--
