-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: idx_labgt_otp_details_created_date
-- Type: INDEX

-- Name: idx_labgt_otp_details_created_date; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX idx_labgt_otp_details_created_date ON labgt.labgt_otp_details USING btree (created_date);


--
