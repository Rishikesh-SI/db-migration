-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: combine_idx
-- Type: INDEX

-- Name: combine_idx; Type: INDEX; Schema: labmi; Owner: -
--

CREATE INDEX combine_idx ON labmi.labmi_otp_details USING btree (mobile_no, otp);


--
