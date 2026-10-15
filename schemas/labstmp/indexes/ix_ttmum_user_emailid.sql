-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labstmp; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labstmp.labstmp_user USING btree (email_id);


--
