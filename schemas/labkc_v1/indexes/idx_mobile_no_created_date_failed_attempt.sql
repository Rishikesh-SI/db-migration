-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: idx_mobile_no_created_date_failed_attempt
-- Type: INDEX

-- Name: idx_mobile_no_created_date_failed_attempt; Type: INDEX; Schema: labkc_v1; Owner: -
--

CREATE INDEX idx_mobile_no_created_date_failed_attempt ON labkc_v1.labkc_v1_otp_details USING btree (mobile_no, created_date, failed_attempt);


--
