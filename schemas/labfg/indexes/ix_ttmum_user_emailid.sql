-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labfg; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labfg.labfg_user USING btree (email_id);


--
