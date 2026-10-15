-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_user_role_uid
-- Type: INDEX

-- Name: ix_ttgl_user_role_uid; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_user_role_uid ON ttgl.ttgl_user_role USING btree (user_id);


--
