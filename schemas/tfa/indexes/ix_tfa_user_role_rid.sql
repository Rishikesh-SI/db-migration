-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_user_role_rid
-- Type: INDEX

-- Name: ix_tfa_user_role_rid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_user_role_rid ON tfa.tfa_user_role USING btree (role_id);


--
