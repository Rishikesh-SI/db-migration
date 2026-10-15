-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_user_role_uid
-- Type: INDEX

-- Name: ix_kxp_user_role_uid; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_user_role_uid ON labkxp1.labkxp_user_role USING btree (user_id);


--
