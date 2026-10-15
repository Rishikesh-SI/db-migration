-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_user_role_uid
-- Type: INDEX

-- Name: ix_cfc_user_role_uid; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_user_role_uid ON cfc.cfc_user_role USING btree (user_id);


--
