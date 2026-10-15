-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: ix_dd_user_role_uid
-- Type: INDEX

-- Name: ix_dd_user_role_uid; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX ix_dd_user_role_uid ON dd_30_04_24.dd_user_role USING btree (user_id);


--
