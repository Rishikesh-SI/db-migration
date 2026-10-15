-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_user_role_uid
-- Type: INDEX

-- Name: ix_yho_user_role_uid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_user_role_uid ON yho.yho_user_role USING btree (user_id);


--
