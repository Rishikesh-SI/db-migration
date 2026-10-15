-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ix_ttmum_user_role_uid
-- Type: INDEX

-- Name: ix_ttmum_user_role_uid; Type: INDEX; Schema: ttmum; Owner: -
--

CREATE INDEX ix_ttmum_user_role_uid ON ttmum.ttmum_user_role USING btree (user_id);


--
