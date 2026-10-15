-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labgg; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labgg.labgg_user USING btree (email_id);


--
