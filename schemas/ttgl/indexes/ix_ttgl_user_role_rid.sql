-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_user_role_rid
-- Type: INDEX

-- Name: ix_ttgl_user_role_rid; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_user_role_rid ON ttgl.ttgl_user_role USING btree (role_id);


--
