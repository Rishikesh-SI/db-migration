-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: idx_labgt01_v1_web_user_created_date_shifted
-- Type: INDEX

-- Name: idx_labgt01_v1_web_user_created_date_shifted; Type: INDEX; Schema: labgt01_v1; Owner: -
--

CREATE INDEX idx_labgt01_v1_web_user_created_date_shifted ON labgt01_v1.labgt01_v1_web_user USING btree (date((created_date + '05:30:00'::interval)));


--
