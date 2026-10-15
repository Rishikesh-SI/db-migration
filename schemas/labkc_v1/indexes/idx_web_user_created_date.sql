-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: idx_web_user_created_date
-- Type: INDEX

-- Name: idx_web_user_created_date; Type: INDEX; Schema: labkc_v1; Owner: -
--

CREATE INDEX idx_web_user_created_date ON labkc_v1.labkc_v1_web_user USING btree (created_date);


--
