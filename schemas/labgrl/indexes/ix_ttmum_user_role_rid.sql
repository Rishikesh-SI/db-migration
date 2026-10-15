-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: ix_ttmum_user_role_rid
-- Type: INDEX

-- Name: ix_ttmum_user_role_rid; Type: INDEX; Schema: labgrl; Owner: -
--

CREATE INDEX ix_ttmum_user_role_rid ON labgrl.labgrl_user_role USING btree (role_id);


--
