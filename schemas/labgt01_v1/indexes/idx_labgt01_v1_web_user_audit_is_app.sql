-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: idx_labgt01_v1_web_user_audit_is_app
-- Type: INDEX

-- Name: idx_labgt01_v1_web_user_audit_is_app; Type: INDEX; Schema: labgt01_v1; Owner: -
--

CREATE INDEX idx_labgt01_v1_web_user_audit_is_app ON labgt01_v1.labgt01_v1_web_user_audit USING btree (is_app);


--
