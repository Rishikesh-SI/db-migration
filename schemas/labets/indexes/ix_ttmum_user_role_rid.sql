-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: ix_ttmum_user_role_rid
-- Type: INDEX

-- Name: ix_ttmum_user_role_rid; Type: INDEX; Schema: labets; Owner: -
--

CREATE INDEX ix_ttmum_user_role_rid ON labets.labets_user_role USING btree (role_id);


--
