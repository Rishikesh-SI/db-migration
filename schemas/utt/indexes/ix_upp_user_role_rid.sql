-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: ix_upp_user_role_rid
-- Type: INDEX

-- Name: ix_upp_user_role_rid; Type: INDEX; Schema: utt; Owner: -
--

CREATE INDEX ix_upp_user_role_rid ON utt.utt_user_role USING btree (role_id);


--
