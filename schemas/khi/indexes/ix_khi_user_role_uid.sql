-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_user_role_uid
-- Type: INDEX

-- Name: ix_khi_user_role_uid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_user_role_uid ON khi.khi_user_role USING btree (user_id);


--
