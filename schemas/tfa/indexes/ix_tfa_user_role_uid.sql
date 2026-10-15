-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_user_role_uid
-- Type: INDEX

-- Name: ix_tfa_user_role_uid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_user_role_uid ON tfa.tfa_user_role USING btree (user_id);


--
