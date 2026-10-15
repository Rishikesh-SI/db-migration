-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: idx_otp_details_created_date_app_country
-- Type: INDEX

-- Name: idx_otp_details_created_date_app_country; Type: INDEX; Schema: labgt01_v1; Owner: -
--

CREATE INDEX idx_otp_details_created_date_app_country ON labgt01_v1.labgt01_v1_otp_details USING btree ((((created_date + '05:30:00'::interval))::date), is_app, country_code);


--
