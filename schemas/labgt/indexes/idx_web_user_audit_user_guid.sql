-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: idx_web_user_audit_user_guid
-- Type: INDEX

-- Name: idx_web_user_audit_user_guid; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX idx_web_user_audit_user_guid ON labgt.labgt_web_user_audit USING btree (user_guid);


--
