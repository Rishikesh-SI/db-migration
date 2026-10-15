-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: idx_web_user_audit_user_guid_is_app_opt2
-- Type: INDEX

-- Name: idx_web_user_audit_user_guid_is_app_opt2; Type: INDEX; Schema: labkc_v1; Owner: -
--

CREATE INDEX idx_web_user_audit_user_guid_is_app_opt2 ON labkc_v1.labkc_v1_web_user_audit USING btree (client_code, user_guid, is_app) WHERE (option_type = (2)::numeric);


--
