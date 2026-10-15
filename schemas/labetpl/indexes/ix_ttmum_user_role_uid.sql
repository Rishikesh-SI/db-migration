-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: ix_ttmum_user_role_uid
-- Type: INDEX

-- Name: ix_ttmum_user_role_uid; Type: INDEX; Schema: labetpl; Owner: -
--

CREATE INDEX ix_ttmum_user_role_uid ON labetpl.labetpl_user_role USING btree (user_id);


--
