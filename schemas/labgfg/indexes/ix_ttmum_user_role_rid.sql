-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: ix_ttmum_user_role_rid
-- Type: INDEX

-- Name: ix_ttmum_user_role_rid; Type: INDEX; Schema: labgfg; Owner: -
--

CREATE INDEX ix_ttmum_user_role_rid ON labgfg.labgfg_user_role USING btree (role_id);


--
