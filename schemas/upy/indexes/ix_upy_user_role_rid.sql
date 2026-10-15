-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_user_role_rid
-- Type: INDEX

-- Name: ix_upy_user_role_rid; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_user_role_rid ON upy.upy_user_role USING btree (role_id);


--
