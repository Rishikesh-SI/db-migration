-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_user_role_uid
-- Type: INDEX

-- Name: ix_mum_user_role_uid; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_user_role_uid ON tmm.tmm_user_role USING btree (user_id);


--
