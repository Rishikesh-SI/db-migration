-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_user_role_uid
-- Type: INDEX

-- Name: ix_zeven_user_role_uid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_user_role_uid ON zeven.zeven_user_role USING btree (user_id);


--
