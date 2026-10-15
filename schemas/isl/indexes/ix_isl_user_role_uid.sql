-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_user_role_uid
-- Type: INDEX

-- Name: ix_isl_user_role_uid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_user_role_uid ON isl.isl_user_role USING btree (user_id);


--
