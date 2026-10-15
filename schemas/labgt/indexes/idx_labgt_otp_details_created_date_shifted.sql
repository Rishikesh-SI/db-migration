-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: idx_labgt_otp_details_created_date_shifted
-- Type: INDEX

-- Name: idx_labgt_otp_details_created_date_shifted; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX idx_labgt_otp_details_created_date_shifted ON labgt.labgt_otp_details USING btree (date((created_date + '05:30:00'::interval)));


--
