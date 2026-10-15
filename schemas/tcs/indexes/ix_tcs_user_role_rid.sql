-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_user_role_rid
-- Type: INDEX

-- Name: ix_tcs_user_role_rid; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_user_role_rid ON tcs.tcs_user_role USING btree (role_id);


--
