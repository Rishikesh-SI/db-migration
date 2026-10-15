-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_user_role_uid
-- Type: INDEX

-- Name: ix_abp_user_role_uid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_user_role_uid ON abpp.abp_user_role USING btree (user_id);


--
