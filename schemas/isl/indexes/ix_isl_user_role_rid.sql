-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_user_role_rid
-- Type: INDEX

-- Name: ix_isl_user_role_rid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_user_role_rid ON isl.isl_user_role USING btree (role_id);


--
