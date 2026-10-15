-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labboost; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labboost.labboost_user USING btree (email_id);


--
