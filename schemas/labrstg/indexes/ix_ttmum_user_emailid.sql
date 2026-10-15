-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labrstg; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labrstg.labrstg_user USING btree (email_id);


--
