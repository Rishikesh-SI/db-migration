-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_user_role_uid
-- Type: INDEX

-- Name: ix_mum_user_role_uid; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_user_role_uid ON dhm.dhm_user_role USING btree (user_id);


--
