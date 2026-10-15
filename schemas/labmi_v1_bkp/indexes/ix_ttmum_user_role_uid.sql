-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1_bkp
-- Object: ix_ttmum_user_role_uid
-- Type: INDEX

-- Name: ix_ttmum_user_role_uid; Type: INDEX; Schema: labmi_v1_bkp; Owner: -
--

CREATE INDEX ix_ttmum_user_role_uid ON labmi_v1_bkp.labmi_v1_user_role USING btree (user_id);


--
