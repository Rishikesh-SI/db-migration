-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: idx_labgt_otp_details_is_app
-- Type: INDEX

-- Name: idx_labgt_otp_details_is_app; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX idx_labgt_otp_details_is_app ON labgt.labgt_otp_details USING btree (is_app);


--
