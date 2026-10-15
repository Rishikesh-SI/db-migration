-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: ix_ttmum_user_role_rid
-- Type: INDEX

-- Name: ix_ttmum_user_role_rid; Type: INDEX; Schema: labrg; Owner: -
--

CREATE INDEX ix_ttmum_user_role_rid ON labrg.labrg_user_role USING btree (role_id);


--
