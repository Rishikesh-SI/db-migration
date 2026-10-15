-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: ix_otp_details_mn_ug
-- Type: INDEX

-- Name: ix_otp_details_mn_ug; Type: INDEX; Schema: labmi_beta_22042024; Owner: -
--

CREATE INDEX ix_otp_details_mn_ug ON labmi_beta_22042024.labmi_otp_details USING btree (mobile_no, user_guid);


--
