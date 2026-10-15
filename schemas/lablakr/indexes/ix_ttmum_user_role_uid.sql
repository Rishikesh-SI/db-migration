-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: ix_ttmum_user_role_uid
-- Type: INDEX

-- Name: ix_ttmum_user_role_uid; Type: INDEX; Schema: lablakr; Owner: -
--

CREATE INDEX ix_ttmum_user_role_uid ON lablakr.lablakr_user_role USING btree (user_id);


--
