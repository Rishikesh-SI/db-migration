-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: ix_ttmum_user_role_uid
-- Type: INDEX

-- Name: ix_ttmum_user_role_uid; Type: INDEX; Schema: labpvl; Owner: -
--

CREATE INDEX ix_ttmum_user_role_uid ON labpvl.labpvl_user_role USING btree (user_id);


--
