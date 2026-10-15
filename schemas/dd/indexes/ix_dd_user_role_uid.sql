-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_dd_user_role_uid
-- Type: INDEX

-- Name: ix_dd_user_role_uid; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_dd_user_role_uid ON dd.dd_user_role USING btree (user_id);


--
