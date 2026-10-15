-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: ix_ttmum_user_role_uid
-- Type: INDEX

-- Name: ix_ttmum_user_role_uid; Type: INDEX; Schema: labwpl; Owner: -
--

CREATE INDEX ix_ttmum_user_role_uid ON labwpl.labwpl_user_role USING btree (user_id);


--
