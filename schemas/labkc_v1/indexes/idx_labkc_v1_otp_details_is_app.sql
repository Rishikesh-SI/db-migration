-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: idx_labkc_v1_otp_details_is_app
-- Type: INDEX

-- Name: idx_labkc_v1_otp_details_is_app; Type: INDEX; Schema: labkc_v1; Owner: -
--

CREATE INDEX idx_labkc_v1_otp_details_is_app ON labkc_v1.labkc_v1_otp_details USING btree (is_app);


--
