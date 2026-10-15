-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: ix_otp_details_mn_ug
-- Type: INDEX

-- Name: ix_otp_details_mn_ug; Type: INDEX; Schema: labmi_v1; Owner: -
--

CREATE INDEX ix_otp_details_mn_ug ON labmi_v1.labmi_v1_otp_details USING btree (mobile_no, user_guid);


--
