-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: idx_otp_details_created_date_client_code
-- Type: INDEX

-- Name: idx_otp_details_created_date_client_code; Type: INDEX; Schema: labkc_v1; Owner: -
--

CREATE INDEX idx_otp_details_created_date_client_code ON labkc_v1.labkc_v1_otp_details USING btree (created_date, client_code);


--
