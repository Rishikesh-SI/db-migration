-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: idx_user_activity_report
-- Type: INDEX

-- Name: idx_user_activity_report; Type: INDEX; Schema: labirao; Owner: -
--

CREATE UNIQUE INDEX idx_user_activity_report ON labirao.labirao_user_activity_report USING btree (user_id);


--
