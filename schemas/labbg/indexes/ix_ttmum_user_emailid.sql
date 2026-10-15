-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbg
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labbg; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labbg.labbg_user USING btree (email_id);


--
