-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_user_role_rid
-- Type: INDEX

-- Name: ix_khi_user_role_rid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_user_role_rid ON khi.khi_user_role USING btree (role_id);


--
