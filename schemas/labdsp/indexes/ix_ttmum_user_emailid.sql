-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labdsp; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labdsp.labdsp_user USING btree (email_id);


--
