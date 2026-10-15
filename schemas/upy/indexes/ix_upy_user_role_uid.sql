-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_user_role_uid
-- Type: INDEX

-- Name: ix_upy_user_role_uid; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_user_role_uid ON upy.upy_user_role USING btree (user_id);


--
