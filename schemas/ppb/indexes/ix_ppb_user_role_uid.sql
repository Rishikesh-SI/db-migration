-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_user_role_uid
-- Type: INDEX

-- Name: ix_ppb_user_role_uid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_user_role_uid ON ppb.ppb_user_role USING btree (user_id);


--
