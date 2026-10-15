-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: ix_ttmum_user_role_uid
-- Type: INDEX

-- Name: ix_ttmum_user_role_uid; Type: INDEX; Schema: labdd_v1; Owner: -
--

CREATE INDEX ix_ttmum_user_role_uid ON labdd_v1.labdd_v1_user_role USING btree (user_id);


--
