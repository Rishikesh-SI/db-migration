-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_user_role_uid
-- Type: INDEX

-- Name: ix_stn_user_role_uid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_user_role_uid ON stn.stn_user_role USING btree (user_id);


--
