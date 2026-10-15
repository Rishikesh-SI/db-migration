-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: idx_labkc_otpless_details_created_date
-- Type: INDEX

-- Name: idx_labkc_otpless_details_created_date; Type: INDEX; Schema: labkc_v1; Owner: -
--

CREATE INDEX idx_labkc_otpless_details_created_date ON labkc_v1.labkc_v1_otpless_details USING btree (created_date);


--
