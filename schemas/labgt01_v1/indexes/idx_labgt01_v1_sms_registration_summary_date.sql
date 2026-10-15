-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: idx_labgt01_v1_sms_registration_summary_date
-- Type: INDEX

-- Name: idx_labgt01_v1_sms_registration_summary_date; Type: INDEX; Schema: labgt01_v1; Owner: -
--

CREATE INDEX idx_labgt01_v1_sms_registration_summary_date ON labgt01_v1.labgt01_v1_sms_registration_summary USING btree (date);


--
