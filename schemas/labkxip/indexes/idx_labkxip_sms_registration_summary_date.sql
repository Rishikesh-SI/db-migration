-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: idx_labkxip_sms_registration_summary_date
-- Type: INDEX

-- Name: idx_labkxip_sms_registration_summary_date; Type: INDEX; Schema: labkxip; Owner: -
--

CREATE INDEX idx_labkxip_sms_registration_summary_date ON labkxip.labkxip_sms_registration_summary USING btree (date);


--
