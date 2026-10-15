-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: idx_labgt_web_user_created_date_shifted
-- Type: INDEX

-- Name: idx_labgt_web_user_created_date_shifted; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX idx_labgt_web_user_created_date_shifted ON labgt.labgt_web_user USING btree (date((created_date + '05:30:00'::interval)));


--
