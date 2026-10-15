-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_user_role_uid
-- Type: INDEX

-- Name: ix_scom_user_role_uid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_user_role_uid ON scom.scom_user_role USING btree (user_id);


--
