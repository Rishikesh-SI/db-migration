-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: idx_labgt_web_user_audit_is_app
-- Type: INDEX

-- Name: idx_labgt_web_user_audit_is_app; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX idx_labgt_web_user_audit_is_app ON labgt.labgt_web_user_audit USING btree (is_app);


--
