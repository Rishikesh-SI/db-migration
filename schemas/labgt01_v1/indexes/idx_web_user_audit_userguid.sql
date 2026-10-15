-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: idx_web_user_audit_userguid
-- Type: INDEX

-- Name: idx_web_user_audit_userguid; Type: INDEX; Schema: labgt01_v1; Owner: -
--

CREATE INDEX idx_web_user_audit_userguid ON labgt01_v1.labgt01_v1_web_user_audit USING btree (user_guid, option_type, client_code, is_app);


--
