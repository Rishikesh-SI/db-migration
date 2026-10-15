-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: idx_labisl_v1_sms_registration_summary_date
-- Type: INDEX

-- Name: idx_labisl_v1_sms_registration_summary_date; Type: INDEX; Schema: labisl_v1; Owner: -
--

CREATE INDEX idx_labisl_v1_sms_registration_summary_date ON labisl_v1.labisl_v1_sms_registration_summary USING btree (date);


--
