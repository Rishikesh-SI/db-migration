-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: idx_labdd_v1_sms_registration_summary_date
-- Type: INDEX

-- Name: idx_labdd_v1_sms_registration_summary_date; Type: INDEX; Schema: labdd_v1; Owner: -
--

CREATE INDEX idx_labdd_v1_sms_registration_summary_date ON labdd_v1.labdd_v1_sms_registration_summary USING btree (date);


--
