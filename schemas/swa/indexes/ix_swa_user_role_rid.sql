-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_user_role_rid
-- Type: INDEX

-- Name: ix_swa_user_role_rid; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_user_role_rid ON swa.swa_user_role USING btree (role_id);


--
