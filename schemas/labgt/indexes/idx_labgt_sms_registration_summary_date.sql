-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: idx_labgt_sms_registration_summary_date
-- Type: INDEX

-- Name: idx_labgt_sms_registration_summary_date; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX idx_labgt_sms_registration_summary_date ON labgt.labgt_sms_registration_summary USING btree (date);


--
