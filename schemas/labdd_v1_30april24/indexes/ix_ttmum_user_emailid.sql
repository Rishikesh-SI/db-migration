-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1_30april24
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labdd_v1_30april24; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labdd_v1_30april24.labdd_v1_user USING btree (email_id);


--
