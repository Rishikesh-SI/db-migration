-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: combine_idx
-- Type: INDEX

-- Name: combine_idx; Type: INDEX; Schema: labmi_v1; Owner: -
--

CREATE INDEX combine_idx ON labmi_v1.labmi_v1_otp_details USING btree (mobile_no, otp);


--
