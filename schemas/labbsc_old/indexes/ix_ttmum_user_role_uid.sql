-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: ix_ttmum_user_role_uid
-- Type: INDEX

-- Name: ix_ttmum_user_role_uid; Type: INDEX; Schema: labbsc_old; Owner: -
--

CREATE INDEX ix_ttmum_user_role_uid ON labbsc_old.labbsc_user_role USING btree (user_id);


--
