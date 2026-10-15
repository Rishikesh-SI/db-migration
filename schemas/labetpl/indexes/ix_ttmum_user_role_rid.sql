-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: ix_ttmum_user_role_rid
-- Type: INDEX

-- Name: ix_ttmum_user_role_rid; Type: INDEX; Schema: labetpl; Owner: -
--

CREATE INDEX ix_ttmum_user_role_rid ON labetpl.labetpl_user_role USING btree (role_id);


--
