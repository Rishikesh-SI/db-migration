-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labwis; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labwis.labwis_user USING btree (email_id);


--
